# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pysmssend/pysmssend-9999.ebuild,v 1.1 2010/10/18 08:09:01 hwoarang Exp $

PYTHON_DEPEND="2:2.5"

EAPI="2"

inherit distutils eutils python multilib git

DESCRIPTION="Python Application for sending sms over multiple ISPs"
HOMEPAGE="http://pysmssend.sourceforge.net/"
EGIT_REPO_URI="git://github.com/hwoarang/pysmssend.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="qt4"

RDEPEND="${DEPEND}
		>=dev-python/mechanize-0.1.9
		qt4? ( >=dev-python/PyQt4-4.3[X] )"

S="${WORKDIR}/pysmssend"

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
