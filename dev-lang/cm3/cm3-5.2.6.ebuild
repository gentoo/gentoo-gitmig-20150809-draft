# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/cm3/cm3-5.2.6.ebuild,v 1.1 2003/07/17 17:19:20 vapier Exp $

DESCRIPTION="Critical Mass Modula-3 compiler"
HOMEPAGE="http://www.elegosoft.com/cm3/"
SRC_URI="http://www.elegosoft.com/cm3/${PN}-src-all-${PV}.tgz"

LICENSE="CMASS-M3 DEC-M3"
SLOT="0"
KEYWORDS="~x86"
IUSE="tcltk"

DEPEND="tcltk? ( dev-lang/tcl )
	sys-devel/gcc
	dev-lang/cm3-bin"

S=${WORKDIR}

export GCC_BACKEND="yes"
export M3GDB="no"
export HAVE_SERIAL="no"
unset M3GC_SIMPLE
[ `use tcltk` ] \
	&& HAVE_TCL="yes" \
	|| HAVE_TCL="no"

src_compile() {
	cd scripts
	for s in do-cm3-core do-cm3-base ; do
		env -u P ROOT=${S} ./${s}.sh build || die "building ${s}"
	done
}

src_install() {
	local TARGET=`grep 'TARGET.*=' /usr/bin/cm3.cfg | awk '{print $4}' | sed 's:"::g'`
	sed -i "s:\"/usr/lib/cm3/:\"${D}/usr/lib/cm3/:g" `find -name .M3SHIP` || die "fixing .M3SHIP"

	cd scripts
	dodir /usr/lib/cm3
	for s in do-cm3-core do-cm3-base ; do
		env -u P ROOT=${S} ./${s}.sh ship || die "shipping ${s}"
	done
	cd ${D}/usr/lib/cm3/pkg
	sed -i "s:${S}/.*-.*/:/usr/lib/cm3/pkg/:" `grep -RIl /var/tmp/portage *` || die "fixing .M3EXPORTS"

	# do all this crazy linking so as to overwrite cm3-bin stuff
	dodir /usr/bin
	insinto /usr/lib/cm3/bin
	doins /usr/bin/cm3.cfg
	dosym /usr/lib/cm3/pkg/cm3/${TARGET}/cm3 /usr/lib/cm3/bin/cm3
	dosym /usr/lib/cm3/bin/cm3 /usr/bin/cm3
	dosym /usr/lib/cm3/bin/cm3cg /usr/bin/cm3cg
	dosym /usr/lib/cm3/bin/cm3.cfg /usr/bin/cm3.cfg
	dobin ${FILESDIR}/m3{build,ship}

	insinto /etc/env.d
	doins ${FILESDIR}/05cm3
	return 0

	# old code left in so i can save it in cvs if i need it in the future ...
	local pkgs=""
	grep P= do-cm3-base.sh > my-base-pkgs ; echo 'echo $P' >> my-base-pkgs
	grep P= do-cm3-core.sh > my-core-pkgs ; echo 'echo $P' >> my-core-pkgs
	pkgs="$(export TARGET=${TARGET}; source my-base-pkgs ; source my-core-pkgs )"
	dodir /usr/lib/cm3/pkg
	for p in ${pkgs} ; do
		pdir=`find ${S} -type d -name ${p} -maxdepth 2 -mindepth 2`
		pkg=`basename ${p}`
		[ -e ${D}/usr/lib/cm3/pkg/${pkg} ] && continue

		# install by hand ...
		#cp -rf ${pdir} ${D}/usr/lib/cm3/pkg/${pkg}
		#cd ${D}/usr/lib/cm3/pkg/${pkg}/${TARGET}
		#rm *.{i,m}o .M3SHIP
		#cd ${D}/usr/lib/cm3/pkg/${pkg}/src
		#find -type f \
		#	! -name '*.i3' -a \
		#	! -name '*.m3' -a \
		#	! -name '*.ig' -a \
		#	! -name '*.mg' -a \
		#	! -name '*.c' -a \
		#	! -name '*.h' -a \
		#	! -name '*.tmpl' \
		#	-exec rm '{}' \;

		# translate m3ship file into portage
		cd ${pdir}/${TARGET}
		echo "=== package ${pdir} ==="	# mimic cm3 output
		my_m3ship
		echo " ==> ${pdir} done"
		echo
	done
}

my_m3ship() {
	[ ! -e .M3SHIP ] && echo "package was built with overrides, not shipping." && return 0
	local act
	local src
	local dst
	local perms
	local l
	while read LINE ; do
		# each line has the format:
		# action("source file", "dest file", "permissions")
		# unless of course the action doesnt need the extra params (i.e. make_dir)
		# we translate it into 'action sourcefile destfile permissions'
		l=$(echo ${LINE} | sed -e 's:[" )]::g' -e 's:[(,]: :g')
		set -- ${l}
		act=${1}
		src=${2}
		dst=${3}
		perms=${4}
		case ${act} in
			install_file)	insinto ${dst}
					doins ${src}
					fperms ${perms} ${dst}/$(basename ${src});;
			make_dir)	dodir ${src};;
			link_file)	dosym ${src} ${dst};;
			*)		die "unknown M3SHIP action ${act}";;
		esac
		debug-print ACT: ${act} SRC: ${src} DST: ${dst} PERMS: ${perms}
	done < .M3SHIP
}
