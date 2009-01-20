# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/root/root-5.22.00.ebuild,v 1.3 2009/01/20 18:04:09 bicatali Exp $

EAPI=2
inherit versionator eutils qt4 fortran elisp-common fdo-mime toolchain-funcs

#DOC_PV=$(get_major_version)_$(get_version_component_range 2)
DOC_PV=5_21
ROOFIT_DOC_PV=2.91-33
TMVA_DOC_PV=4

DESCRIPTION="C++ data analysis framework and interpreter from CERN"
SRC_URI="ftp://root.cern.ch/${PN}/${PN}_v${PV}.source.tar.gz
	mirror://gentoo/${P}-patches.tar.bz2
	doc? ( ftp://root.cern.ch/root/doc/Users_Guide_${DOC_PV}.pdf
		ftp://root.cern.ch/root/doc/RooFit_Users_Manual_${ROOFIT_DOC_PV}.pdf
		http://tmva.sourceforge.net/docu/TMVAUsersGuide.pdf -> TMVAUsersGuide-${TMVA_DOC_PV}.pdf )"

HOMEPAGE="http://root.cern.ch/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"

IUSE="afs cern cint7 clarens doc emacs examples fftw geant4 kerberos ldap
	+math mysql	odbc openmp oracle postgres pythia6 pythia8 python +reflex
	ruby qt4 ssl xml xinetd xrootd"

# libafterimage ignored, to check every version
# see https://savannah.cern.ch/bugs/?func=detailitem&item_id=30944
#	|| ( >=media-libs/libafterimage-1.15 x11-wm/afterstep )
CDEPEND=">=dev-lang/cfortran-4.4-r2
	dev-libs/libpcre
	>=media-libs/ftgl-2.1.3_rc5
	media-libs/libpng
	media-libs/jpeg
	media-libs/giflib
	media-libs/tiff
	sys-apps/shadow
	virtual/opengl
	virtual/glu
	x11-libs/libXpm
	x11-libs/libXft
	afs? ( >=net-fs/openafs-1.4.7 )
	clarens? ( dev-libs/xmlrpc-c )
	emacs? ( virtual/emacs )
	fftw? ( sci-libs/fftw:3.0 )
	geant4? ( sci-physics/geant:4 )
	kerberos? ( virtual/krb5 )
	ldap? ( net-nds/openldap )
	math? ( >=sci-libs/gsl-1.8 )
	mysql? ( virtual/mysql )
	odbc? ( || ( dev-db/libiodbc dev-db/unixODBC ) )
	oracle? ( dev-db/oracle-instantclient-basic )
	postgres? ( virtual/postgresql-base )
	pythia6? ( sci-physics/pythia:6 )
	pythia8? ( sci-physics/pythia:8 )
	python? ( dev-lang/python )
	qt4? ( || ( ( x11-libs/qt-gui:4
			x11-libs/qt-opengl:4
			x11-libs/qt-qt3support:4
			x11-libs/qt-xmlpatterns:4 )
			x11-libs/qt:4[qt3support,opengl] ) )
	ruby? ( dev-lang/ruby )
	ssl? ( dev-libs/openssl )
	xml? ( dev-libs/libxml2 )"

DEPEND="${CDEPEND}
	dev-util/pkgconfig"

RDEPEND="${CDEPEND}
	xinetd? ( sys-apps/xinetd )"

S="${WORKDIR}/${PN}"

pkg_setup() {
	elog
	elog "You may want to build ROOT with these non Gentoo extra packages:"
	elog "AliEn, castor, Chirp, dCache, gfal, gLite, Globus,"
	elog "Monalisa, MaxDB/SapDB, SRP."
	elog "You can use the env variable EXTRA_ECONF variable for this."
	elog "For example, for SRP, you would set: "
	elog "EXTRA_ECONF=\"--enable-srp --with-srp-libdir=/usr/$(get_libdir)\""
	elog
	if use cern; then
		FORTRAN="gfortran g77 ifc"
		fortran_pkg_setup
	else
		unset F77
	fi
	enewgroup rootd
	enewuser rootd -1 -1 /var/spool/rootd rootd

	if use openmp &&
		[[ $(tc-getCC)$ == *gcc* ]] &&
		( [[ $(gcc-major-version)$(gcc-minor-version) -lt 42 ]] ||
			! built_with_use sys-devel/gcc openmp ); then
		ewarn "You are using gcc and OpenMP is available with gcc >= 4.2"
		ewarn "If you want to build this package with OpenMP, abort now,"
		ewarn "and set CC to an OpenMP capable compiler"
		epause 5
	elif use openmp; then
		export USE_OPENMP=1
		use math && export USE_PARALLEL_MINUIT2=1
	fi
}

src_prepare() {

	epatch "${WORKDIR}"/${P}-prop-flags.patch
	epatch "${WORKDIR}"/${P}-as-needed.patch
	epatch "${WORKDIR}"/${P}-xrootd-shared.patch
	epatch "${WORKDIR}"/${P}-xrootd-prop-flags.patch
	epatch "${WORKDIR}"/${P}-configure-paths.patch

	# use system cfortran
	rm montecarlo/eg/inc/cfortran.h README/cfortran.doc

	# take a more descriptive name for ruby libs
	sed -i \
		-e 's/libRuby/libRubyROOT/g' \
		bindings/ruby/Module.mk bindings/ruby/src/drr.cxx \
		|| die "ajusting ruby libname failed"

	# in gentoo, libPythia6 is called libpythia6
	# libungif is called libgif, and libftgl_pic is libftgl
	sed -i \
		-e 's/libPythia6/libpythia6/g' \
		-e 's/ungif/gif/g' \
		-e 's/ftgl_pic/ftgl/g' \
		configure || die "adjusting library names failed"

	# libafterimage flags are hardcoded
	sed -i \
		-e 's/CFLAGS="-O3"//' \
		-e 's/CFLAGS=$$ACFLAGS//' \
		graf2d/asimage/Module.mk graf2d/asimage/src/libAfterImage/configure \
		|| die "flag propagation in libafterimage failed"
	# QTDIR only used for qt3 in gentoo, and configure looks for it.
	unset QTDIR
}

src_configure() {
	# the configure script is not the standard autotools
	./configure \
		--fail-on-missing \
		--prefix=/usr \
		--libdir=/usr/$(get_libdir)/${PN} \
		--docdir=/usr/share/doc/${PF} \
		--tutdir=/usr/share/doc/${PF}/examples/tutorials \
		--testdir=/usr/share/doc/${PF}/examples/tests \
		--with-sys-iconpath=/usr/share/pixmaps \
		--disable-builtin-afterimage \
		--disable-builtin-freetype \
		--disable-builtin-ftgl \
		--disable-builtin-pcre \
		--disable-builtin-zlib \
		--disable-rpath \
		--enable-asimage \
		--enable-astiff \
		--enable-exceptions	\
		--enable-explicitlink \
		--enable-gdml \
		--enable-memstat \
		--enable-opengl \
		--enable-shadowpw \
		--enable-shared	\
		--enable-soversion \
		--enable-table \
		--enable-xft \
		$(use_enable afs) \
		$(use_enable cint7) \
		$(use_enable clarens) \
		$(use_enable clarens peac) \
		$(use_enable fftw fftw3) \
		$(use_enable geant4 g4root) \
		$(use_enable kerberos krb5) \
		$(use_enable ldap) \
		$(use_enable math gsl-shared) \
		$(use_enable math genvector) \
		$(use_enable math mathmore) \
		$(use_enable math minuit2) \
		$(use_enable math roofit) \
		$(use_enable math unuran) \
		$(use_enable mysql) \
		$(use_enable odbc) \
		$(use_enable postgres pgsql) \
		$(use_enable pythia6) \
		$(use_enable pythia8) \
		$(use_enable python) \
		$(use_enable qt4 qt) \
		$(use_enable qt4 qtgsi) \
		$(use_enable reflex cintex) \
		$(use_enable reflex) \
		$(use_enable ruby) \
		$(use_enable ssl) \
		$(use_enable xml) \
		$(use_enable xrootd) \
		${EXTRA_ECONF} \
		|| die "configure failed"
}

src_compile() {
	emake OPT="" || die "emake failed"
	emake cintdlls || die "emake cintdlls failed"
	if use emacs; then
		elisp-compile build/misc/*.el || die "elisp-compile failed"
	fi
}

doc_install() {
	cd "${S}"
	if use doc; then
		einfo "Installing user's guides"
		insinto /usr/share/doc/${PF}
		doins \
			"${DISTDIR}"/Users_Guide_${DOC_PV}.pdf \
			"${DISTDIR}"/TMVAUsersGuide_v${TMVA_DOC_PV}.pdf \
			|| die "pdf install failed"
		if use math; then
			doins "${DISTDIR}"/RooFit_Users_Manual_${ROOFIT_DOC_PV}.pdf \
				|| die "math doc install failed"
		fi
	fi

	if use examples; then
		# these should really be taken care of by the root make install
		insinto /usr/share/doc/${PF}/examples/tutorials/tmva
		doins -r tmva/test || die
	else
		rm -rf "${D}"/usr/share/doc/${PF}/examples
	fi
}

daemon_install() {
	cd "${S}"
	local daemons="rootd proofd"
	dodir /var/spool/rootd
	fowners rootd:rootd /var/spool/rootd
	dodir /var/spool/rootd/{pub,tmp}
	fperms 1777 /var/spool/rootd/{pub,tmp}

	use xrootd && daemons="${daemons} xrootd olbd"
	for i in ${daemons}; do
		newinitd "${FILESDIR}"/${i}.initd ${i}
		newconfd "${FILESDIR}"/${i}.confd ${i}
	done
	if use xinetd; then
		insinto /etc/xinetd
		doins etc/daemons/{rootd,proofd}.xinetd || die
	fi
}

desktop_install() {
	cd "${S}"
	sed -e 's,@prefix@,/usr,' \
		build/package/debian/root-system-bin.desktop.in > root.desktop
	domenu root.desktop
	doicon "${S}"/build/package/debian/root-system-bin.png

	insinto /usr/share/icons/hicolor/hicolor/48x48/mimetypes
	doins build/package/debian/application-x-root.png

	insinto /usr/share/icons/hicolor/hicolor/48x48/apps
	doicon build/package/debian/root-system-bin.xpm
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	echo "LDPATH=/usr/$(get_libdir)/root" > 99root
	use pythia8 && echo "PYTHIA8=/usr" >> 99root
	use python && echo "PYTHONPATH=/usr/$(get_libdir)/root" >> 99root
	use ruby && echo "RUBYLIB=/usr/$(get_libdir)/root" >> 99root
	doenvd 99root || die "doenvd failed"

	# The build system installs Emacs support unconditionally and in the wrong
	# directory. Remove it and call elisp-install in case of USE=emacs.
	rm -rf "${D}"/usr/share/emacs
	if use emacs; then
		elisp-install ${PN} build/misc/*.{el,elc} || die "elisp-install failed"
	fi

	doc_install
	daemon_install
	desktop_install

	# Cleanup of files either already distributed or unused on Gentoo
	rm "${D}"usr/share/doc/${PF}/{INSTALL,LICENSE,COPYING.CINT}
	rm "${D}"usr/share/root/fonts/LICENSE
	pushd "${D}"usr/$(get_libdir)/root/cint/cint/lib > /dev/null
	rm -f posix/mktypes dll_stl/setup \
		G__* dll_stl/G__* dll_stl/rootcint_* posix/exten.o
	rm -f "${D}"usr/$(get_libdir)/root/cint/cint/include/makehpib
	rm -f "${D}"/etc/root/proof/*.sample
	rm -rf "${D}"/etc/root/daemons
	popd > /dev/null
}

pkg_postinst() {
	use ruby && elog "ROOT Ruby  module is available as libRubyROOT"
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
