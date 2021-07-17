# Natural climate reconstruction with VAE
The goal of this project is to understand variational autoencoders (VAEs) and to apply this model to a real-world dataset.

The dataset consists of time series of internal and external temperature and relative humidity took from three different sensors in a Stave Church.</br>
Stave Churches are a particular kind of wooden building that was common in northern Europe. Nowadays, many of them are both a tourism attraction and also used for hosting religious celebrations, meaning that there is active exploitation of the heating system. This is, unfortunately, threatening the state of these buildings, and a safeguard campaign has started. To this end, it is important to reconstruct what the natural internal climate of the church would be in absence of heating.

Exploiting a VAE, we aim to start from spoilt data and filter out the heating events, in such a way as to recreate the natural climate of the church.

In detail, the notebooks in the repository are
