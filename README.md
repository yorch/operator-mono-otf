# Operator Mono Font Downloader and OTF Converter

This tool allows you to download the font Operator Mono and convert it to OTF.

## Download

```sh
./download.sh
```

## Convert to OTF

```sh
./convert.sh
```

## Ligatures

To add ligatures to the OTF fonts that you've downloaded and converted:

```sh
./add-ligatures.sh
```

Which uses the tool from this [repo](https://github.com/kiliman/operator-mono-lig) with
this [Docker wrapper](https://github.com/drod3763/kiliman-operator-mono-lig-docker)
