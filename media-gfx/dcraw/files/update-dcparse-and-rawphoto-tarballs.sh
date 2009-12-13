#!/bin/bash

# update parse and rawphoto tarballs

echo "Updating parse tarbal..." 
tmpdir=$(mktemp -d)
cd ${tmpdir}
for file in parse.c rawphoto.c; do
	wget "http://www.cybercom.net/~dcoffin/dcraw/${file}" && \
	mkdir dcraw && \
	mv ${file} dcraw && \
	tar jcvf ${file/.c}-$(awk '/Revision:/{print $2}' dcraw/${file}).tar.bz2 dcraw
	if [[ $? != 0 ]]; then
		echo "Unable to update ${file}."
		exit 1
	fi
	cd ${tmpdir} && rm -r dcraw
done

echo "Grab tarballs at ${tmpdir} move into $(portageq distdir) and update ebuild."
