# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/rpm.eclass,v 1.4 2003/06/21 14:22:18 liquidx Exp $

# Author : Alastair Tse <liquidx@gentoo.org> (21 Jun 2003)
#
# Convienence class for extracting RPMs
# 
# Basically, rpm_src_unpack does:
#
# 1. convert all *.rpm in ${A} to tar.gz, non rpm files are passed through 
#    unpack()
# 2. unpacks the tar.gz into ${WORKDIR}
# 3. if it is a source rpm, it finds all .tar .tar.gz, .tgz, .tbz2, .tar.bz2,
#    .zip, .ZIP and unpacks them using unpack() (with a little hackery)
# 4. deletes all the unpacked tarballs and zip files from ${WORKDIR}
#
# Warning !!
#
# Sometimes, pure rpm2targz will fail on certain RPMs (eg: scim-chinese)
# because their code for detecting RPM header offset is not good enough.
# In that case, you need to add app-arch/rpm to your DEPEND. rpm2targz
# will automatically find rpm2cpio and use it instead of its own rpmoffset.
#
# In addition, rpm2targz-8.0 behaves differently from rpm2targz-9.0. The newer
# versions will autodetect rpm2cpio whereas 8.0 doesn't. 
#
# Also, 9.0 will place files in ${prefix%.src} if extracting a source rpm
# whereas 8.0 will just place them in the current directory. 
# As of writing, the current rpm2targz-9.0 in portage has been patched to
# remove this behaviour for backwards compatibility.

ECLASS="rpm"
INHERITED="$INHERITED $ECLASS"

newdepend "app-arch/rpm2targz"

rpm_src_unpack() {
	local x prefix ext myfail OLD_DISTDIR
	
	for x in ${A}; do
		myfail="failure unpacking ${x}"
		ext=${x##*.}
		case "$ext" in
		rpm)
			echo ">>> Unpacking ${x}"
			prefix=${x%.rpm}
			cd ${WORKDIR}
			# convert rpm to tar.gz and then extract
			rpm2targz ${DISTDIR}/${x} || die "${myfail}"
			if [ "$(tar tzvf ${WORKDIR}/${prefix}.tar.gz | wc -l)" -lt 2 ]; then
				die "rpm2targz failed, produced an empty tar.gz"
			fi
			tar xz --no-same-owner -f ${WORKDIR}/${prefix}.tar.gz || die "${myfail}"
			rm -f ${WORKDIR}/${prefix}.tar.gz
			
			# find all tar.gz files and extract for srpms
			if [ "${prefix##*.}" = "src" ]; then
				OLD_DISTDIR=${DISTDIR}
				DISTDIR=${WORKDIR}
				findopts="* -maxdepth 0 -name *.tar"
				for t in *.tar.gz *.tgz *.tbz2 *.tar.bz2 *.zip *.ZIP; do
					findopts="${findopts} -o -name ${t}"
				done
				for t in $(find ${findopts} | xargs); do
					unpack ${t}
					rm -f ${t}
				done
				DISTDIR=${OLD_DISTDIR}
			fi				
			;;
		*)
			unpack ${x}
			;;
		esac
	done
			
}

EXPORT_FUNCTIONS src_unpack
