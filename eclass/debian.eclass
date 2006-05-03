# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/debian.eclass,v 1.1 2006/05/03 07:49:27 stuart Exp $

# Author : Jonathan Scruggs <j.scruggs@gmail.com> (09 April 2006)
# Based on rpm.eclass by : Alastair Tse <liquidx@gentoo.org> (21 Jun 2003)
#
# Convienence class for extracting DEBs
#
# Basically, deb_src_unpack does:
#
# 1. uses debian_unpack to unpack a deb file using ar from binutils.
# 2. deletes all the unpacked tarballs and zip files from ${WORKDIR}
# NOTE: deb2targz requiers perl, and that is not a package installed
#       by default. ar comes with binutils, so everyone should have
#       this already, and no need for a dependency of a really large
#       package like perl. Some users may never need perl.
#
# This ebuild now re-defines a utility function called deb_unpack which
# basically extracts the files out of the deb. It does not gzip the
# output tar again but directly extracts to ${WORKDIR}
#
# I don't know if this will handle RPMs in the list, but it will with
# other regular files that the unpack command can handle. :)


# extracts the contents of the DEP in ${WORKDIR}
debian_unpack() {
	local debfile targzfile return_value
	debfile=$1

	if [ -z "${debfile}" ]; then
		return_value=1
	else
		ar x ${debfile}
		# remove unneeded files.
		rm -f control.tar.gz debian-binary

		# Make this multi-file friendly.
		# Rename this for nice output during emerge, so
		# Users know what file is being extracted, rahter
		# than seeing data.tar.gz all the time.
		targzfile=${debfile##*\/}
		targzfile=${targzfile//.deb/.tar.gz}
		mv data.tar.gz ${targzfile}

		return_value=0
	fi

	return ${return_value}
}

debian_src_unpack() {
	local x targzfile ext myfail OLD_DISTDIR

	for x in ${A}; do
		myfail="failure unpacking ${x}"
		ext=${x##*.}
		case "$ext" in
		deb)
			echo ">>> Unpacking ${x}"
			cd ${WORKDIR}
			debian_unpack ${DISTDIR}/${x} || die "${myfail}"

			# Needed to unpack data.tar.gz
			OLD_DISTDIR=${DISTDIR}
			DISTDIR=${WORKDIR}
			targzfile=${x##*\/}
			targzfile=${targzfile//.deb/.tar.gz}
			unpack ${targzfile}
			rm -f ${targzfile}
			DISTDIR=${OLD_DISTDIR}
			;;
		*)
			unpack ${x}
			;;
		esac
	done
}

EXPORT_FUNCTIONS src_unpack
