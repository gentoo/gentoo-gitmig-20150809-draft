# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/reportlab/reportlab-2.1.ebuild,v 1.7 2008/04/24 17:33:31 corsair Exp $

NEED_PYTHON=2.4

inherit distutils versionator

MY_PV="$(replace_all_version_separators _)"

DESCRIPTION="Tools for generating printable PDF documents from any data source."
HOMEPAGE="http://www.reportlab.org/"
SRC_URI="http://www.reportlab.org/ftp/ReportLab_${MY_PV}.tgz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="doc examples"

DEPEND="sys-libs/zlib
	dev-python/imaging
	media-fonts/ttf-bitstream-vera"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}_${MY_PV}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PV}-tests_report_failure.patch"
	epatch "${FILESDIR}/${PV}-test_fix.patch"

	sed -i \
		-e "/'docs/d" -e "/'test/d" \
		-e "/'fonts/d" -e "/demos/d" \
		setup.py || die "sed failed"

	sed -i \
		-e 's|/usr/lib/X11/fonts/TrueType/|/usr/share/fonts/ttf-bitstream-vera/|' \
		-e 's|/usr/local/Acrobat|/opt/Acrobat|g' \
		-e 's|%(HOME)s/fonts|%(HOME)s/.fonts|g' \
		-e 's|%(REPORTLAB_DIR)s/../../fonts|/usr/share/fonts|' \
		rl_config.py || die "sed failed"

	# A rather useless test which rebuilds the docs and fails
	# since it calls python using os.system but doesn't pass
	# the PYTHONPATH env-variable along
	rm "${S}/test/test_docs_build.py"
	# ... and remove yet another broken test
	rm "${S}/test/test_platypus_paragraphs.py"
}

src_install() {
	distutils_src_install

	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins -r docs/*
	fi
	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r demos
		insinto /usr/share/doc/${PF}/tools/pythonpoint
		doins -r tools/pythonpoint/demos
	fi
}

src_test() {
	cd "${S}/test"
	PYTHONPATH="../.." ${python} runAll.py || die "tests failed"
}
