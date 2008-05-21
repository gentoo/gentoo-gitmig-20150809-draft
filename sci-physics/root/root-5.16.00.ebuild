# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/root/root-5.16.00.ebuild,v 1.11 2008/05/21 19:02:38 dev-zero Exp $

inherit versionator flag-o-matic eutils toolchain-funcs qt3 fortran

DOC_PV=$(get_major_version)_$(get_version_component_range 2)

DESCRIPTION="C++ data analysis framework and interpreter from CERN"
SRC_URI="ftp://root.cern.ch/${PN}/${PN}_v${PV}.source.tar.gz
	doc? ( ftp://root.cern.ch/root/doc/Users_Guide_${DOC_PV}.pdf )"
HOMEPAGE="http://root.cern.ch/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="amd64 sparc x86"

IUSE="afs cern doc fftw kerberos ldap mysql odbc postgres
	python ruby qt3 ssl truetype xml"

DEPEND="sys-apps/shadow
	x11-libs/libXpm
	>=sci-libs/gsl-1.8
	dev-libs/libpcre
	virtual/opengl
	virtual/glu
	|| ( media-libs/libafterimage x11-wm/afterstep )
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-server )
	afs? ( net-fs/openafs )
	kerberos? ( virtual/krb5 )
	ldap? ( net-nds/openldap )
	qt3? ( $(qt_min_version 3.3.4) )
	fftw? ( >=sci-libs/fftw-3 )
	python? ( dev-lang/python )
	ruby? ( dev-lang/ruby )
	ssl? ( dev-libs/openssl )
	xml? ( dev-libs/libxml2 )
	cern? ( sci-physics/cernlib )
	odbc? ( dev-db/unixODBC )
	truetype? ( x11-libs/libXft )"

S="${WORKDIR}/${PN}"

pkg_setup() {
	elog
	elog "You may want to build ROOT with these non Gentoo extra packages:"
	elog "AliEn, castor, Chirp, clarens, Globus, Monalisa, Oracle, peac, "
	elog "PYTHIA, PYTHIA6, SapDB, SRP, Venus"
	elog "You can use the EXTRA_CONF variable for this."
	elog "Example, for PYTHIA, you would do: "
	elog "EXTRA_CONF=\"--enable-pythia --with-pythia-libdir=/usr/$(get_libdir)\" emerge root"
	elog
	epause 10
	if use cern; then
		FORTRAN="gfortran g77 ifc"
		fortran_pkg_setup
	fi
	if [[ "$(tc-getCXX)" == *g++* ]] && \
		version_is_at_least 4.2 $(gcc-version); then
		eerror "${P} will not compile with g++ >= 4.2"
		eerror "Either downgrade gcc, use another C++ compiler or use root >= 5.18."
		die "wrong g++ version"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# patch to properly set link flags with fortran compilers
	epatch "${FILESDIR}"/${P}-fortran.patch
	if [[ ${ARCH} == sparc ]]; then
		cd "${S}/xrootd/src"
		tar xzf xrootd-20060928-1600.src.tgz
		epatch "${FILESDIR}"/sparc-${P}.patch
		tar czf xrootd-20060928-1600.src.tgz xrootd
	fi
}

src_compile() {

	local target
	if [[ "$(tc-getCXX)" == icc* ]]; then
		if use amd64; then
			target=linuxx8664icc
		elif use x86; then
			target=linuxicc
		fi
	fi
	use afs && append-flags -DAFS_OLD_COM_ERR
	local myfortran
	use cern && myfortran="F77=${FORTRANC}"

	# watch: the configure script is not the standard autotools
	# disable-pch: precompiled headers buggy with icc

	./configure ${target} \
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
		--tutdir=/usr/share/doc/${PF}/tutorial \
		--elispdir=/usr/share/emacs/site-lisp \
		--etcdir=/etc/${PN} \
		--disable-alien \
		--disable-builtin-afterimage \
		--disable-builtin-freetype \
		--disable-builtin-pcre \
		--disable-builtin-zlib \
		--disable-chirp \
		--disable-dcache \
		--disable-globus \
		--disable-pch \
		--disable-rfio \
		--disable-rpath \
		--disable-sapdb \
		--disable-srp \
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
		--enable-shared	\
		--enable-soversion \
		--enable-table \
		--enable-unuran \
		--enable-xrootd \
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
		$(use_enable ruby) \
		$(use_enable ssl) \
		$(use_enable truetype xft) \
		$(use_enable xml) \
		${EXTRA_CONF} \
		|| die "configure failed"

	emake \
		OPTFLAGS="${CXXFLAGS}" \
		${myfortran} \
		|| die "emake failed"

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
