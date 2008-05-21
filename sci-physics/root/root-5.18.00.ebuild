# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/root/root-5.18.00.ebuild,v 1.5 2008/05/21 19:02:38 dev-zero Exp $

inherit versionator flag-o-matic eutils toolchain-funcs qt3 qt4 fortran

#DOC_PV=$(get_major_version)_$(get_version_component_range 2)
DOC_PV=5_16

DESCRIPTION="C++ data analysis framework and interpreter from CERN"
SRC_URI="ftp://root.cern.ch/${PN}/${PN}_v${PV}.source.tar.gz
	doc? ( ftp://root.cern.ch/root/doc/Users_Guide_${DOC_PV}.pdf )"
HOMEPAGE="http://root.cern.ch/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"

IUSE="afs cern cint7 doc fftw kerberos ldap mysql odbc pch postgres
	python ruby qt3 qt4 ssl truetype xml"

RDEPEND="sys-apps/shadow
	x11-libs/libXpm
	media-libs/ftgl
	>=sci-libs/gsl-1.8
	dev-libs/libpcre
	virtual/opengl
	virtual/glu
	|| ( >=media-libs/libafterimage-1.15 x11-wm/afterstep )
	afs? ( net-fs/openafs )
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-server )
	kerberos? ( virtual/krb5 )
	ldap? ( net-nds/openldap )
	qt3? ( !qt4? ( $(qt_min_version 3.3.4) ) )
	qt4? ( $(qt4_min_version 4.3) )
	fftw? ( >=sci-libs/fftw-3 )
	python? ( dev-lang/python )
	ruby? ( dev-lang/ruby )
	ssl? ( dev-libs/openssl )
	xml? ( dev-libs/libxml2 )
	cern? ( sci-physics/cernlib )
	odbc? ( dev-db/unixODBC )
	truetype? ( x11-libs/libXft )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${PN}"

QT4_BUILT_WITH_USE_CHECK="qt3support"

pkg_setup() {
	elog
	elog "You may want to build ROOT with these non Gentoo extra packages:"
	elog "AliEn, castor, Chirp, clarens, gfal, Globus, GEANT4, Monalisa, "
	elog "Oracle, peac, PYTHIA, PYTHIA6, SapDB, SRP, Venus"
	elog "You can use the EXTRA_ECONF variable for this."
	elog "Example, for PYTHIA, you would do: "
	elog "EXTRA_ECONF=\"--enable-pythia --with-pythia-libdir=/usr/$(get_libdir)\" emerge root"
	elog
	epause 7
	if use cern; then
		FORTRAN="gfortran g77 ifc"
		fortran_pkg_setup
	fi
	use qt4 && qt4_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-5.16.00-xft.patch
	epatch "${FILESDIR}"/${PN}-pic.patch
}

src_compile() {

	local target
	local myconf="--disable-pch"
	use pch && myconf="--enable-pch"
	if [[ "$(tc-getCXX)" == icc* ]]; then
		if use amd64; then
			target=linuxx8664icc
		elif use x86; then
			target=linuxicc
		fi
		myconf="--disable-pch"
	fi

	local myfortran
	use cern && \
		myfortran="${FORTRANC} ${FFLAGS}"

	# watch: the configure script is not the standard autotools
	./configure \
		${target} \
		${myconf} \
		--with-f77="${myfortran}" \
		--with-cc="$(tc-getCC) ${CFLAGS}" \
		--with-cxx="$(tc-getCXX) ${CXXFLAGS}" \
		--prefix=/usr \
		--bindir=/usr/bin \
		--mandir=/usr/share/man/man1 \
		--incdir=/usr/include/${PN} \
		--libdir=/usr/$(get_libdir)/${PN} \
		--aclocaldir=/usr/share/aclocal/ \
		--datadir=/usr/share/${PN} \
		--cintincdir=/usr/share/${PN}/cint \
		--fontdir=/usr/share/${PN}/fonts \
		--iconpath=/usr/share/${PN}/icons \
		--macrodir=/usr/share/${PN}/macros \
		--srcdir=/usr/share/${PN}/src \
		--docdir=/usr/share/doc/${PF} \
		--testdir=/usr/share/doc/${PF}/test \
		--tutdir=/usr/share/doc/${PF}/tutorials \
		--elispdir=/usr/share/emacs/site-lisp \
		--etcdir=/etc/${PN} \
		--disable-builtin-afterimage \
		--disable-builtin-freetype \
		--disable-builtin-ftgl \
		--disable-builtin-pcre \
		--disable-builtin-zlib \
		--enable-asimage \
		--enable-astiff \
		--enable-cintex \
		--enable-exceptions	\
		--enable-explicitlink \
		--enable-gdml \
		--enable-mathcore \
		--enable-mathmore \
		--enable-minuit2 \
		--enable-opengl \
		--enable-reflex \
		--enable-roofit \
		--enable-shadowpw \
		--enable-shared	\
		--enable-soversion \
		--enable-table \
		--enable-unuran \
		--enable-xrootd \
		$(use_enable cint7) \
		$(use_enable pch) \
		$(use_enable afs) \
		$(use_enable cern) \
		$(use_enable fftw fftw3) \
		$(use_enable kerberos krb5) \
		$(use_enable ldap) \
		$(use_enable mysql) \
		$(use_enable odbc) \
		$(use_enable postgres pgsql) \
		$(use_enable python) \
		$(use_enable qt3 qt) \
		$(use_enable qt3 qtgsi) \
		$(use_enable qt4 qt) \
		$(use_enable qt4 qtgsi) \
		$(use_enable ruby) \
		$(use_enable ssl) \
		$(use_enable truetype xft) \
		$(use_enable xml) \
		${EXTRA_ECONF} \
		|| die "configure failed"

	emake || die "emake failed"

	# is this only for windows? not quite sure.
	emake cintdlls || die "emake cintdlls failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	echo "LDPATH=/usr/$(get_libdir)/root" > 99root
	doenvd 99root || die "doenvd failed"

	if use doc; then
		einfo "Installing user's guide and ref manual"
		insinto /usr/share/doc/${PF}
		doins "${DISTDIR}"/Users_Guide_${DOC_PV}.pdf \
			|| die "pdf install failed"
	fi
}
