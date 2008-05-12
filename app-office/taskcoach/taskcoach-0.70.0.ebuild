# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/taskcoach/taskcoach-0.70.0.ebuild,v 1.1 2008/05/12 19:32:15 caster Exp $

inherit distutils eutils

MY_PN="TaskCoach"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Simple personal tasks and todo lists manager"
HOMEPAGE="http://www.taskcoach.org"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
	mirror://gentoo/${PN}-icon.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=">=dev-lang/python-2.4"
RDEPEND="${DEPEND}
	=dev-python/wxpython-2.8*"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt"

src_install() {
	distutils_src_install

	mv "${D}/usr/bin/taskcoach.py" "${D}/usr/bin/taskcoach" || die
	rm "${D}/usr/bin/taskcoach.pyw" || die

	doicon "${WORKDIR}/${PN}-icon/${PN}.png" || die
	make_desktop_entry ${PN} "Task Coach" ${PN} Office || die
}
