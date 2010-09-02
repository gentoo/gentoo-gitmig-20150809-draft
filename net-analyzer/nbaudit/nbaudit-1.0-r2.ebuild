# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nbaudit/nbaudit-1.0-r2.ebuild,v 1.2 2010/09/02 18:00:02 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs

# It is officially called nat10 but the name conflicts with other projects
# so I'm following the *BSDs suggestion of calling it nbaudit

MY_P=nat10
S=${WORKDIR}/${MY_P}
DESCRIPTION="NetBIOS file sharing services scanner (nat10)"
SRC_URI="http://www.tux.org/pub/security/secnet/tools/nat10/${MY_P}.tgz"
HOMEPAGE="http://www.tux.org/pub/security/secnet/tools/nat10/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=sys-apps/sed-4"
RDEPEND=""

src_prepare() {
	epatch ${FILESDIR}/${P}-gentoo.diff
	sed -i Makefile \
		-e 's:-lshadow::' \
		-e 's|^CFLAGS = |CFLAGS +=|g' \
		-e 's| $(CFLAGS) -o | $(LDFLAGS) &|g' \
		|| die "sed Makefile"
}

src_compile() {
	emake CC=$(tc-getCC) all || die "make failed"
}

src_install () {
	newbin nat nbaudit
	newman nat.1 nbaudit.1
	dodoc README
}
