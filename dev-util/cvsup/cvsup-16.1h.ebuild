# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsup/cvsup-16.1h.ebuild,v 1.8 2004/02/17 20:09:09 vapier Exp $

MY_P="${P/-/-snap-}"
EZM3="ezm3-1.1"
EZM3_TARGET="LINUXLIBC6"
EZM3_INSTALL="${S}/${EZM3}-install"	#// anywhere or having a trailing / makes the compile dies

DESCRIPTION="a faster alternative to cvs"
HOMEPAGE="http://www.cvsup.org/"
SRC_URI="ftp://ftp3.freebsd.org/pub/FreeBSD/development/CVSup/sources/${MY_P}.tar.gz
	ftp://ftp.freebsd.org/pub/FreeBSD/development/CVSup/ezm3/${EZM3}-src.tar.bz2
	ftp://ftp.freebsd.org/pub/FreeBSD/development/CVSup/ezm3/${EZM3}-${EZM3_TARGET}-boot.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-* x86 ~ppc"
IUSE="X opengl static"

DEPEND="virtual/glibc
	dev-util/yacc
	>=sys-apps/sed-4
	ppc? ( dev-lang/cm3 )"
RDEPEND="virtual/glibc"

S=${WORKDIR}

seduse() {
	[ -z "`use ${1}`" ] && echo "${2}" || echo ":"
}

src_unpack() {
	unpack ${A}
	[ ${ARCH} == "ppc" ] && epatch ${FILESDIR}/${PV}-ppc.patch
}

src_compile() {
	if [ ${ARCH} != "ppc" ] ; then
	########################
	### BEGIN EZM3 SETUP ###
	########################

	# when you do make, ezm3 builds & installs at the same time so we control
	# where it is going to install the compiler and stuff
	# (to not violate sandbox)
	cd ${S}/${EZM3}/m3config/src
	sed -i \
		-e "s:/usr/local:${EZM3_INSTALL}:" ${EZM3_TARGET} || \
			die "sed ${EZM3_TARGET} failed"
	echo "M3CC_MAKE = [\"make\", \"BISON=yacc\"]" >> ${EZM3_TARGET}

	# now we disable X and OpenGL if the user doesnt have them in their USE var
	sed -i \
		-e "s:/usr/local:${EZM3_INSTALL}:" \
	 	-e "s:touch:ranlib:" \
	 	-e "s:`seduse X 'import_X11():import_X11() is\nend\nproc dont_import_X11()'`:" \
		-e "s:`seduse opengl 'import_OpenGL():import_OpenGL() is\nend\nproc dont_import_OpenGL()'`:" \
			COMMON || \
				die "sed COMMON failed"

	# finally we compile the m3 compiler
	# we clear the CFLAGS because:
	#	(1) higher optimizations cause issues
	#	(2) it doesnt matter ... we arent installing the compiler ...
	# we clea the P because:
	#	newer build system uses this variable and having it breaks it
	cd ${S}/${EZM3}
	env -u CFLAGS -u P make || die "ezm3 compile failed"
	fi

	#########################
	### BEGIN CVSUP SETUP ###
	#########################

	# first we disable the gui (if no X) and enable static (if static is in USE)
	cd ${S}/${MY_P}
	local mym3flags=""
	use static	&&	mym3flags="${mym3flags} -DSTATIC"
	use X		||	mym3flags="${mym3flags} -DNOGUI"
	[ "${mym3flags:0:1}" == " " ] && mym3flags="${mym3flags:1}"
	sed -i \
		-e "s:/usr/local:${D}/usr:" \
	 	-e "s:^M3FLAGS=:M3FLAGS=${mym3flags}:" Makefile || \
			die "sed Makefile failed"

	# then we fix the /usr/local/etc/cvsup paths in all the files
	for f in `grep /usr/local/etc * -Rl` ; do
		sed -i \
			-e "s:/usr/local/etc:/etc:" ${f} || \
				die "sed ${f} failed"
	done

	# then we compile cvsup
	env PATH="${EZM3_INSTALL}/bin:${PATH}" make || die "cvsup compile failed"

	# now we do up the html pages ...
	cd ${S}/${MY_P}/doc
	make || die "html pages failed to compile !?"
	for f in `ls *.html` ; do
		sed -i \
			-e "s:images/::" ${f} || \
				die "sed ${f} failed"
	done
	mv ${S}/${MY_P}/doc/images/* ${S}/${MY_P}/doc/
}

src_install() {
	S="${S}/${MY_P}"

	for f in `find ${S} -perm +1 -type f | grep -v doc` ; do
		dobin ${f} || die "dobin failed (${f})"
	done

	doman ${S}/client/${EZM3_TARGET}/cvsup.1 \
		${S}/cvpasswd/${EZM3_TARGET}/cvpasswd.1 \
		${S}/server/${EZM3_TARGET}/cvsupd.8 || \
			die "doman failed"

	dohtml ${S}/doc/*.{html,gif} || die "dohtml failed"

	dodoc ${S}/{Acknowledgments,Announce,Blurb,ChangeLog,License,Install} || \
		die "dodoc failed"

	insinto /etc/cvsup
	doins ${FILESDIR}/gentoo.sup ${FILESDIR}/gentoo_mirror.sup || \
		die "doins failed"

	exeinto /etc/init.d
	newexe ${FILESDIR}/cvsupd.rc cvsupd || die "newexe failed"

	insinto /etc/conf.d
	newins ${FILESDIR}/cvsupd.confd cvsupd || die "newins failed"

	dodir /var/cvsup || die "dodir failed"
}
