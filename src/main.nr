use dep::std;

global NUM_OF_CLIENTS: u32 = 6;

fn main(x_param: [u32; NUM_OF_CLIENTS], y_param: [u32; NUM_OF_CLIENTS], threshold_score: pub u32) -> pub [u32; NUM_OF_CLIENTS] {

    let mut result = [0; NUM_OF_CLIENTS];

    let mut score = [0; NUM_OF_CLIENTS];

    // std::println("Printing x_param");
    // std::println(x_param);
    // std::println("Printing y_param");
    // std::println(y_param);

    let mut bad_actors: bool = false;
    for i in 0..NUM_OF_CLIENTS {
        score[i] = get_score(i, x_param, y_param);
    }

    // std::println("Printing score");
    // std::println(score);

    let mean_score = get_mean_score(score);
    let standard_deviation = get_standard_deviation(score);

    // std::println("Printing mean_score");
    // std::println(mean_score);
    // std::println("Printing standard_deviation");
    // std::println(standard_deviation);

    let mut bracket1: u32 = 0;
    let mut bracket2: u32 = 0;
    for i in 0..NUM_OF_CLIENTS {
        if (score[i] > (mean_score - standard_deviation/2) & score[i] < mean_score) {
            bracket1 += 1;
        }
        else if (score[i] > mean_score & score[i] < (mean_score + (3 * standard_deviation) / 2)) {
            bracket2 += 1;
        }
    }

    // std::println("Number of elements in lower bracket");
    // std::println(bracket1);
    // std::println("Number of elements in upper bracket");
    // std::println(bracket2);
    if (bracket1 > bracket2) {
        bad_actors = true;
    }

    if (bad_actors) {
        for i in 0..NUM_OF_CLIENTS {
            if (score[i] > mean_score + threshold_score * standard_deviation) {
                result[i] = 1;
            }
        }
    }   
    result
}

fn get_score(k: u32, x_param: [u32; NUM_OF_CLIENTS], y_param: [u32; NUM_OF_CLIENTS]) -> u32 {
    let mut param_score = 0;
    for i in 0..NUM_OF_CLIENTS {
        let mut diff_x = 0;
        if (x_param[i] > x_param[k]) {
            diff_x = x_param[i] - x_param[k];
        } else {
            diff_x = x_param[k] - x_param[i];
        }
        let mut diff_y = 0; 
        if (y_param[i] > y_param[k]) {
            diff_y = y_param[i] - y_param[k];
        } else {
            diff_y = y_param[k] - y_param[i];
        }
        param_score += diff_x*diff_x + diff_y*diff_y;
    }
    param_score
}

fn get_mean_score(score: [u32; NUM_OF_CLIENTS]) -> u32 {
    let mut mean_score = 0;
    for i in 0..NUM_OF_CLIENTS {
        mean_score += score[i];
    }
    mean_score = mean_score / NUM_OF_CLIENTS;
    mean_score
}

fn get_standard_deviation(score: [u32; NUM_OF_CLIENTS]) -> u32 {
    let mean_score = get_mean_score(score);
    let mut standard_deviation = 0;
    for i in 0..NUM_OF_CLIENTS {
        let mut diff = 0;
        if (score[i] > mean_score) {
            diff = score[i] - mean_score;
        } else {
            diff = mean_score - score[i];
        }
        std::println(diff);
        if (diff < 65535) {
        standard_deviation += diff * diff;
        std::println(standard_deviation);
        }
    }
    std::println(standard_deviation);
    standard_deviation = standard_deviation / NUM_OF_CLIENTS;
    std::println(standard_deviation);
    standard_deviation = get_sqrt(standard_deviation);
    standard_deviation
}

fn get_sqrt(x: u32) -> u32 {
    let mut sqrt = 0;
    if (x == 1) {
        sqrt = 1;
    }  
    if (x > 1) {
        let mut a = x/2;
        std::println(a);
        let mut b = x/a;
        std::println(b);
        for _i in 0..3 {
            a = (a + b)/2;
            b = x/a;
        }
        std::println(a);
        sqrt = a;
    }
    sqrt
}

// #[test]
// fn test_main() {
//     main(1, 2);

//     // Uncomment to make test fail
//     // main(1, 1);
// }
