# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-reminder/gkrellm-reminder-0.3.5.ebuild,v 1.5 2002/10/20 18:55:34 vapier Exp $

MY_P=${P/gkrellm-/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="a Reminder Plugin for Gkrellm"
SRC_URI="http://engr.oregonstate.edu/~simonsen/reminder/${MY_P}.tar.gz"
HOMEPAGE="http://www.engr.orst.edu/~simonsen/reminder"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND=">=app-admin/gkrellm-1.2.1"

src_compile() {
	make || die
}

src_install () {
	insinto /usr/lib/gkrellm/plugins
	doins reminder.so
	dodoc README ChangeLog COPYING 
}
