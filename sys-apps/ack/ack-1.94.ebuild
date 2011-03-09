# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ack/ack-1.94.ebuild,v 1.1 2011/03/09 17:16:11 tove Exp $

EAPI=3

MODULE_AUTHOR=PETDANCE
inherit perl-module bash-completion

DESCRIPTION="ack is a tool like grep, aimed at programmers with large trees of heterogeneous source code"
HOMEPAGE="http://betterthangrep.com/ ${HOMEPAGE}"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-interix ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

SRC_TEST=do

DEPEND=">=dev-perl/File-Next-1.02"
RDEPEND="${DEPEND}"

src_install() {
	perl-module_src_install
	dobashcompletion etc/ack.bash_completion.sh
}

pkg_postinst() {
	bash-completion_pkg_postinst
}
