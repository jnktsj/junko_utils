## Downgrading VCF 4.2 to 4.1

There is a thorough way to downgrade the version with bcftools,
as shown in [this github code](https://gist.github.com/danielecook/f1d80babd7d601a74981).
However you can downgrade fairly simply with a sed command:

```
sed -e 's/^##fileformat=VCFv4.2/##fileformat=VCFv4.1/; s/Number=R,/Number=.,/g' $input_vcf | bgzip -c > $output_vcf

# makde an index
tabix -p vcf $output_vcf
```

## Downloading TCGA datasets

[`gdc-client`](https://gdc.cancer.gov/access-data/gdc-data-transfer-tool)
only works on Mac OSX, Windows, and Ubuntu. It will be such a hassle
to set up the tool in a RHEL Linux environment. It seems it is
possible to use the tool via
[`virtualenv`](https://virtualenv.pypa.io/en/stable/) by following
this [recipe](https://www.biostars.org/p/225594/#225891), but the
method did not work for my case.

## Solution (for Mac OSX)
As a tentative solution, the following procedure worked pretty well:
1. mounting a directory on a destination server
2. downloading files to the mounted directory

### Tools to mount a directory
For Mac OSX, you will need the following two tools:
- FUSE for macOS
- SSHFS

Those tools can be found from this [link](https://osxfuse.github.io/).

### Procedure to download TCGA datasets
```shell
# make a mount point
mkdir ${mount_point}
sshfs user@location ${mout_point}

# simply download with gdc-client
gdc-client download --dir ${mout_point} ${download_file_id}
```
