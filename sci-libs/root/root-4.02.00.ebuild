# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/root/root-4.02.00.ebuild,v 1.3 2005/03/29 16:36:44 fmccor Exp $

inherit flag-o-matic eutils

S=${WORKDIR}/${PN}
DESCRIPTION="An Object-Oriented Data Analysis Framework"
MY_VER=${PV%[a-z]}
MY_PATCH=${PV##"${MY_VER}"}
SRC_URI="ftp://root.cern.ch/root/root_v${MY_VER}.source${MY_PATCH}.tar.gz"
HOMEPAGE="http://root.cern.ch/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 -sparc"
IUSE="afs kerberos ldap mysql opengl postgres python qt"

DEPEND="virtual/x11
	>=media-libs/freetype-2.0.9
	sys-apps/shadow
	opengl? ( virtual/opengl virtual/glu )
	mysql? ( >=dev-db/mysql-3.23.49 )
	postgres? ( >=dev-db/postgresql-7.1.3-r4 )
	!amd64? ( afs? ( net-fs/openafs ) )
	kerberos? ( app-crypt/mit-krb5 )
	ldap? ( net-nds/openldap )
	qt? ( x11-libs/qt )
	python? ( dev-lang/python )"

src_compile() {

	local myconf

	if [ "x$CERNLIB" = "x" ]
	then
		einfo "No support for cernlib, (h/g)2root will not be build."
		einfo "To install root with cernlib support, use:"
		einfo "    export CERNLIB=<directory>/lib"
		einfo "where <directory>/lib contains libpacklib.[so,a] and libkernlib.[so,a]"
		USECERN="--disable-cern"
	else
		if [ -e $CERNLIB/libpacklib.[so,a] -a -e $CERNLIB/libkernlib.[so,a] ]
		then
			einfo "Support for cernlib found."
			USECERN="--enable-cern --with-cern-libdir=$CERNLIB"
		else
			einfo "No support for cernlib, (h/g)2root will not be build."
			einfo "CERNLIB = $CERNLIB has no libpacklib.[so,a] or no libkernlib.[so,a]"
			USECERN="--disable-cern"
		fi
	fi
	einfo
	if [ "x$PYTHIA" = "x" ]
	then
		einfo "No support for pythia."
		einfo "To install root with pythia support, use:"
		einfo "    export PYTHIA=<directory>/lib"
		einfo "where <directory>/lib contains libPythia.[so,a]"
		USEPYTHIA="--disable-pythia"
	else
		if [ -e $PYTHIA/libPythia.[so,a] ]
		then
			einfo "Support for pythia found."
			USEPYTHIA="--enable-pythia --with-pythia-libdir=$PYTHIA"
		else
			einfo "No support for pythia."
			einfo "PYTHIA = $PYTHIA has no libPythia.[so,a]"
			USEPYTHIA="--disable-pythia"
		fi
	fi
	einfo
	if [ "x$PYTHIA6" = "x" ]
	then
		einfo "No support for pythia6."
		einfo "To install root with pythia6 support, use:"
		einfo "    export PYTHIA6=<directory>/lib"
		einfo "where <directory>/lib contains libPythia6.[so,a]"
		USEPYTHIA6="--disable-pythia6"
	else
		if [ -e $PYTHIA6/libPythia6.[so,a] ]
		then
			einfo "Support for pythia6 found."
			USEPYTHIA6="--enable-pythia6 --with-pythia6-libdir=$PYTHIA6"
		else
			einfo "No support for pythia6."
			einfo "PYTHIA6 = $PYTHIA6 has no libPythia6.[so,a]"
			USEPYTHIA6="--disable-pythia6"
		fi
	fi
	einfo
	if [ "x$VENUS" = "x" ]
	then
		einfo "No support for venus."
		einfo "To install root with venus support, use:"
		einfo "    export VENUS=<directory>/lib"
		einfo "where <directory>/lib contains libVenus.[so,a]"
		USEVENUS="--disable-venus"
	else
		if [ -e $VENUS/libVenus.[so,a] ]
		then
			einfo "Support for venus found."
			USEVENUS="--enable-venus --with-venus-libdir=$VENUS"
		else
			einfo "No support for venus."
			einfo "VENUS = $VENUS has no libVenus.[so,a]"
			USEVENUS="--disable-venus"
		fi
	fi

	case $SYSTEM_ARCH in
		ppc)
			append-flags "-fsigned-char";;
	esac

	if ! use amd64; then
		myconf="${myconf} $(use_enable afs)"
	else
		myconf="${myconf} --disable-afs"
	fi

	./configure linux \
		--aclocaldir=/usr/share/aclocal/ \
		--bindir=/usr/bin \
		--cintincdir=/usr/share/root/cint \
		--datadir=/usr/share/root \
		--docdir=/usr/share/doc/${P} \
		--elispdir=/usr/share/emacs/site-lisp \
		--etcdir=/etc/root \
		--fontdir=/usr/share/root/fonts \
		--iconpath=/usr/share/root/icons \
		--incdir=/usr/include/root \
		--libdir=/usr/lib/root \
		--macrodir=/usr/share/root/macros \
		--mandir=/usr/share/man/man1 \
		--prefix=/usr \
		--proofdir=/usr/share/root/proof \
		--srcdir=/usr/share/root/src \
		--testdir=/usr/share/doc/${P}/test \
		--tutdir=/usr/share/doc/${P}/tutorial \
		--disable-alien \
		--disable-asimage \
		$USECERN \
		--disable-chirp \
		--disable-dcache \
		--disable-exceptions \
		--disable-explicitlink \
		--disable-globus \
		`use_enable kerberos krb5` \
		`use_enable ldap` \
		`use_enable mysql` \
		`use_enable opengl` \
		`use_enable postgres pgsql` \
		$USEPYTHIA \
		$USEPYTHIA6 \
		`use_enable qt` \
		`use_enable python` \
		--disable-rfio \
		--disable-rpath \
		--disable-sapdb \
		--enable-shadowpw \
		--enable-shared \
		--enable-soversion \
		--disable-srp \
		--disable-table \
		--enable-thread \
		$USEVENUS \
		${myconf} || die "configure failed"
	emake OPT="$CFLAGS" || die "make failed"
}

src_install() {
	make DESTDIR=${D} INSTALL="install" install || die "install failed"
	dodir /etc/env.d
	echo > ${D}/etc/env.d/99root "LDPATH=\"/usr/lib/root\""
}
