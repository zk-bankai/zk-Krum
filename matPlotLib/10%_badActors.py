import numpy as np
import matplotlib.pyplot as plt

# Generate 1000 random vectors with x and y parameters between 40 and 50
np.random.seed(0)  # For reproducibility
vectors = np.random.uniform(40, 50, (1000, 2))  # 1000 vectors, each with x and y in the range 40-50

# Randomly select 50 indices and set their x and y params to range 100-500
np.random.seed(1)  # Different seed for different operation
selected_indices = np.random.choice(1000, 100, replace=False)
vectors[selected_indices] = np.random.uniform(100, 500, (100, 2))

# Calculate score for each vector

scores = np.zeros(1000)
for i in range(1000):
    distances = np.sqrt(((vectors[i] - vectors) ** 2).sum(axis=1))  # Euclidean distances
    scores[i] = np.sum(distances ** 2)  # Sum of squared distances

# Calculate mean and standard deviation of scores
mean_score = np.mean(scores)
std_score = np.std(scores)

# Plotting
plt.figure(figsize=(12, 8))
plt.scatter(range(1000), scores, label='Vector Scores')
plt.scatter(selected_indices, scores[selected_indices], color='red', label='Altered Vectors')
plt.axhline(mean_score, color='r', linestyle='-', label='Mean Score')
plt.axhline(2*mean_score, color='r', linestyle='-', label='Mean Score')
plt.axhline(mean_score + 1.5*(std_score), color='g', linestyle='--', label='Mean Score + Standard Deviation')
plt.axhline(mean_score - 0.5*(std_score), color='g', linestyle='--', label='Mean Score + Standard Deviation')
plt.xlabel('Vector Index')
plt.ylabel('Score')
plt.title('Scores of Vectors Based on Sum of Squared Distances (With Selected Vectors Altered)')
plt.legend()
plt.show()