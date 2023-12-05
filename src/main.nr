global NUM_OF_CLIENTS: u32 = 6;

fn main(x_param: [u32; NUM_OF_CLIENTS], y_param: [u32; NUM_OF_CLIENTS], threshold_score: pub u32) -> pub [u32; NUM_OF_CLIENTS] {

    let mut result = [0; NUM_OF_CLIENTS];

    let mut score = [0; NUM_OF_CLIENTS];
    for i in 0..NUM_OF_CLIENTS {
        score[i] = get_score(i, x_param, y_param);
    }
    let mean_score = get_mean_score(score);

    for i in 0..NUM_OF_CLIENTS {
        if (score[i] > threshold_score * mean_score) {
            result[i] = 1;
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

// fn get_standard_deviation(score: [u32; NUM_OF_CLIENTS]) -> u32 {
//     let mean_score: u32 = get_mean_score(score);
//     let mut standard_deviation: u32 = 0;
//     for i in 0..NUM_OF_CLIENTS {
//         if (score[i] > mean_score) {
//             standard_deviation += score[i] - mean_score;
//         } else {
//             standard_deviation += mean_score - score[i];
//         }
//         standard_deviation = standard_deviation * standard_deviation;
//     }
//     standard_deviation = standard_deviation / NUM_OF_CLIENTS;
//     standard_deviation = get_sqrt(standard_deviation);
//     standard_deviation
// }

// fn get_sqrt(x: u32) -> u32 {
//     let mut sqrt = 0;
//     if (x == 1) {
//         sqrt = 1;
//     }  
//     if (x > 1) {
//         let mut a = x/2;
//         let mut b = x/a;
//         for i in 0..5 {
//             a = (a + b)/2;
//             b = x/a;
//         }
//         sqrt = a;
//     }
//     sqrt
// }

// #[test]
// fn test_main() {
//     main(1, 2);

//     // Uncomment to make test fail
//     // main(1, 1);
// }
