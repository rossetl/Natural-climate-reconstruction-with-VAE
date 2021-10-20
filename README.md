# Natural climate reconstruction with VAE
The goal of this project is to understand variational autoencoders (VAEs) and to apply this type of model to a real-world dataset.

The dataset consists of time series of internal and external temperature and relative humidity taken from three different sensors in a Stave Church.
Stave Churches are a particular kind of wooden building that was common in northern Europe. Nowadays, many of them are both a tourism attraction and also used for hosting religious celebrations, meaning that there is active exploitation of the heating system. Unfortunately, this is threatening the state of these buildings, and a safeguard campaign has started. To this end, it is important to reconstruct what the natural internal climate of the church would be in absence of human intervention.

Exploiting a VAE, we aim to start from spoiled data and filter out the heating events, in such a way as to recreate the natural climate of the church.
In detail, the notebooks in the repository are

In detail, the notebooks in the repository are
- `data_preprocessing`: exploration of the dataset and discussion over the possibility of enlarging the training set
- `VAE_implementation`: the actual implementation of the model with different architectures
