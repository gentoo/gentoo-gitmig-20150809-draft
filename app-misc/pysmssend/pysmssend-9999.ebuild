# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pysmssend/pysmssend-9999.ebuild,v 1.3 2011/05/17 19:54:37 hwoarang Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils eutils git

DESCRIPTION="Python Application for sending sms over multiple ISPs"
HOMEPAGE="http://pysmssend.silverarrow.org/"
EGIT_REPO_URI="git://github.com/hwoarang/pysmssend.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="qt4"

DEPEND=">=dev-python/mechanize-0.1.9
	qt4? ( >=dev-python/PyQt4-4.3[X] )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/pysmssend"

PYTHON_MODNAME="pysmssendmod"

src_prepare() {
	python_convert_shebangs -r 2 .
}

src_install() {
	distutils_src_install
	if use qt4; then
		insinto /usr/share/${PN}/Icons || die "insinto failed"
		doins   Icons/* || die "doins failed"
		doicon  Icons/pysmssend.png || die "doicon failed"
		dobin   pysmssend pysmssendcmd || die "failed to create executables"
		make_desktop_entry pysmssend pySMSsend pysmssend \
			"Applications;Network" || die "make_desktop_entry failed"
	else
		dobin   pysmssendcmd || die "failed to create executable"
		dosym   pysmssendcmd /usr/bin/pysmssend || die "dosym failed"
	fi
	dodoc README AUTHORS TODO || die "dodoc failed"
}
