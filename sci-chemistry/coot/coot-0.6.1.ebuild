# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/coot/coot-0.6.1.ebuild,v 1.9 2011/01/20 12:13:36 hwoarang Exp $

EAPI="3"

PYTHON_DEPEND="2"

inherit autotools base eutils python versionator

MY_S2_PV=$(replace_version_separator 2 - ${PV})
MY_S2_P=${PN}-${MY_S2_PV/pre1/pre-1}
MY_S_P=${MY_S2_P}-${PR/r/revision-}
MY_PV=${PV}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Crystallographic Object-Oriented Toolkit for model building, completion and validation"
HOMEPAGE="http://www.biop.ox.ac.uk/coot/"
SRC_URI="
	http://www.biop.ox.ac.uk/coot/software/source/releases/${MY_P}.tar.gz
	test? ( mirror://gentoo/greg-data-${PV}.tar.gz  )"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

SCIDEPS="
	>=sci-libs/ccp4-libs-6.1
	>=sci-libs/clipper-20090520
	>=sci-libs/coot-data-2
	>=sci-libs/gsl-1.3
	sci-libs/mmdb
	sci-chemistry/reduce
	sci-chemistry/refmac
	sci-chemistry/probe"

XDEPS="
	gnome-base/libgnomecanvas
	gnome-base/librsvg
	media-libs/libpng
	media-libs/freeglut
	>=x11-libs/gtk+-2.2
	x11-libs/gtkglext"

SCHEMEDEPS="
	dev-scheme/net-http
	dev-scheme/guile-gui
	>=dev-scheme/guile-lib-0.1.6
	dev-scheme/guile-www
	~x11-libs/guile-gtk-2.1"

RDEPEND="
	${SCIDEPS}
	${XDEPS}
	${SCHEMEDEPS}
	dev-python/pygtk
	>=dev-libs/gmp-4.2.2-r2
	>=net-misc/curl-7.19.6
	net-dns/libidn"
DEPEND="${RDEPEND}
	dev-lang/swig
	sys-devel/bc
	test? ( dev-scheme/greg )"

S="${WORKDIR}/${MY_P}"
#S="${WORKDIR}/${MY_S2_P}"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	base_src_prepare

	# Link against single-precision fftw
	sed -i \
		-e "s:lfftw:lsfftw:g" \
		-e "s:lrfftw:lsrfftw:g" \
		"${S}"/macros/clipper.m4

	epatch "${FILESDIR}"/${PV}-libpng14.patch

	eautoreconf
}

src_configure() {
	# All the --with's are used to activate various parts.
	# Yes, this is broken behavior.
	econf \
		--includedir='${prefix}/include/coot' \
		--with-gtkcanvas-prefix="${EPREFIX}"/usr \
		--with-clipper-prefix="${EPREFIX}"/usr \
		--with-mmdb-prefix="${EPREFIX}"/usr \
		--with-ssmlib-prefix="${EPREFIX}"/usr \
		--with-gtkgl-prefix="${EPREFIX}"/usr \
		--with-guile \
		--with-python="${EPREFIX}"/usr \
		--with-guile-gtk \
		--with-gtk2 \
		--with-pygtk
}

src_compile() {
	emake || die "emake failed"
	python_convert_shebangs $(python_get_version) src/coot_gtk2.py
	cp "${S}"/src/coot_gtk2.py python/coot.py || die
}

src_test() {
	source "${EPREFIX}/etc/profile.d/40ccp4.setup.sh"
	mkdir "${T}"/coot_test

	export COOT_STANDARD_RESIDUES="${S}/standard-residues.pdb"
	export COOT_SCHEME_DIR="${S}/scheme/"
	export COOT_RESOURCES_FILE="${S}/cootrc"
	export COOT_PIXMAPS_DIR="${S}/pixmaps"
	export COOT_DATA_DIR="${S}"
	export COOT_PYTHON_DIR="${S}/python"
	export PYTHONPATH="${COOT_PYTHON_DIR}:${PYTHONPATH}"
	export PYTHONHOME="${EPREFIX}"/usr
	export CCP4_SCR="${T}"/coot_test
	export CLIBD_MON="${EPREFIX}/usr/share/ccp4/data/monomers/"
	export SYMINFO="${S}/syminfo.lib"

	export COOT_TEST_DATA_DIR="${WORKDIR}"/data/greg-data

	cat > command-line-greg.scm <<- EOF
	(use-modules (ice-9 greg))
		(set! greg-tools (list "greg-tests"))
			(set! greg-debug #t)
			(set! greg-verbose 5)
			(let ((r (greg-test-run)))
				(if r
				(coot-real-exit 0)
				(coot-real-exit 1)))
	EOF

	einfo "Running test with following paths ..."
	einfo "COOT_STANDARD_RESIDUES $COOT_STANDARD_RESIDUES"
	einfo "COOT_SCHEME_DIR $COOT_SCHEME_DIR"
	einfo "COOT_RESOURCES_FILE $COOT_RESOURCES_FILE"
	einfo "COOT_PIXMAPS_DIR $COOT_PIXMAPS_DIR"
	einfo "COOT_DATA_DIR $COOT_DATA_DIR"
	einfo "COOT_PYTHON_DIR $COOT_PYTHON_DIR"
	einfo "PYTHONPATH $PYTHONPATH"
	einfo "PYTHONHOME $PYTHONHOME"
	einfo "CCP4_SCR ${CCP4_SCR}"
	einfo "CLIBD_MON ${CLIBD_MON}"
	einfo "SYMINFO ${SYMINFO}"

	"${S}"/src/coot-real --no-graphics --script command-line-greg.scm || die
}
