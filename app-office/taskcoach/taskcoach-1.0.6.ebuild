# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/taskcoach/taskcoach-1.0.6.ebuild,v 1.1 2010/06/30 12:55:48 caster Exp $

EAPI=3

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_MODNAME="buildlib taskcoachlib"

inherit distutils eutils

MY_PN="TaskCoach"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Simple personal tasks and todo lists manager"
HOMEPAGE="http://www.taskcoach.org"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libnotify"
DEPEND=">=dev-python/wxpython-2.8.9.2:2.8"
RDEPEND="${DEPEND}
	libnotify? ( dev-python/notify-python )"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt"

src_unpack() {
	default

	einfo "Removing Funambol support, works only on x86 and python 2.5."
	rm -fv "${S}"/taskcoachlib/bin.in/linux/*.so || die
}

src_install() {
	distutils_src_install

	# a bit ugly but...
	mv "${D}/usr/bin/taskcoach.py" "${D}/usr/bin/taskcoach" || die
	for file in "${D}"/usr/bin/taskcoach.py-*; do
		dir=$(dirname ${file})
		ver=$(basename ${file})
		ver=${ver#taskcoach.py-}
		mv "${file}" "${dir}/taskcoach-${ver}" || die
	done

	doicon "icons.in/${PN}.png" || die
	make_desktop_entry ${PN} "Task Coach" ${PN} Office || die
}

pkg_postinst() {
	elog "With version 1.0, taskcoach could be stabilized if there is enough user interest."
	elog "If you run a stable stable system and had to keyword taskcoach, please comment/vote"
	elog "on http://bugs.gentoo.org/show_bug.cgi?id=311841"
}
