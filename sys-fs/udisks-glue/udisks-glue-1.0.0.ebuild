# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udisks-glue/udisks-glue-1.0.0.ebuild,v 1.1 2010/10/01 18:01:05 ssuominen Exp $

EAPI=2
inherit toolchain-funcs

DESCRIPTION="A tool to associate udisks events to user-defined actions"
HOMEPAGE="http://github.com/fernandotcl/udisks-glue"
SRC_URI="http://download.github.com/fernandotcl-${PN}-release-${PV}-0-g0ce5c4b.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="dev-libs/dbus-glib
	dev-libs/glib:2
	dev-libs/confuse"
RDEPEND="${COMMON_DEPEND}
	sys-fs/udisks"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/fernandotcl-${PN}-4a2ac2e

src_prepare() {
	sed -i \
		-e 's:-Werror::' \
		-e 's:LDFLAGS+:LIBS+:' \
		-e '/CC/s:$(OBJS):& $(LIBS):' \
		Makefile || die
}

src_compile() {
	tc-export CC
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	doman man/*.1 || die
	dodoc README
}
