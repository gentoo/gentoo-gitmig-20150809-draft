# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-reminder/gkrellm-reminder-0.3.5.ebuild,v 1.8 2003/09/06 05:45:17 msterret Exp $

MY_P=${P/gkrellm-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="a Reminder Plugin for Gkrellm"
SRC_URI="http://engr.oregonstate.edu/~simonsen/reminder/${MY_P}.tar.gz"
HOMEPAGE="http://www.engr.orst.edu/~simonsen/reminder"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc "

DEPEND=">=app-admin/gkrellm-1.2.1"

src_compile() {
	make || die
}

src_install () {
	insinto /usr/lib/gkrellm/plugins
	doins reminder.so
	dodoc README ChangeLog COPYING
}
