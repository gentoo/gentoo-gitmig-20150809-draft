# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/checkpolicy/checkpolicy-1.18.ebuild,v 1.1 2004/11/14 19:02:15 pebenito Exp $

IUSE="mls"

inherit eutils

DESCRIPTION="SELinux policy compiler"
HOMEPAGE="http://www.nsa.gov/selinux"
SRC_URI="http://www.nsa.gov/selinux/archives/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

DEPEND=">=sys-libs/libsepol-1.2
	sys-devel/flex
	sys-devel/bison"

RDEPEND="sec-policy/selinux-base-policy"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i -e "s:-Wall:-Wall ${CFLAGS}:g" -e 's/$(LIBS)/$(LIBS) $(LDFLAGS)/' ${S}/Makefile
	sed -i -e '/^lex\.yy\.c/s/\.l/\.l y\.tab\.c/' ${S}/Makefile

	epatch ${FILESDIR}/checkpolicy-1.16-no-netlink-warn.diff

	# MLS support is experimental!
	if use mls; then
		sed -i -e '/^MLS/s/n/y/' ${S}/Makefile \
			|| die "MLS config failed."
		sed -i -e 's/-mls (/ (mls /' ${S}/checkpolicy.c \
			|| die "MLS output failed."
	fi
}

src_compile() {
	cd ${S}
	emake YACC="bison -y" || die
}

src_install() {
	make DESTDIR="${D}" install
}

pkg_postinst() {
	einfo "This checkpolicy can compile version `checkpolicy -V |cut -f 1 -d ' '` policy."
}
