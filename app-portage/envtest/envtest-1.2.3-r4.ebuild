# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/envtest/envtest-1.2.3-r4.ebuild,v 1.7 2004/12/04 13:48:45 dsd Exp $

DESCRIPTION="This ebuild displays the environment for an ebuild. It's for portage-testing purposes only and will _always_ fail."
HOMEPAGE="http://foo.bar.com/"
SRC_URI="http://gentoo.twobtt.net/portage/portage-2.0.47-r13.tar.bz2"
LICENSE="as-is GPL-2"
SLOT="0"
KEYWORDS="~x86 sparc ppc alpha mips"
IUSE=""
DEPEND=">=sys-apps/portage-2.0.47-r10"

src_compile() {
	set

	die "Died on purpose. You aren't supposed to merge this. Have a nice day. :)"
}

src_install() {
	die "Have a nice day!"
}
