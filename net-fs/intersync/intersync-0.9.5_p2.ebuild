# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/intersync/intersync-0.9.5_p2.ebuild,v 1.5 2004/07/14 23:52:33 agriffis Exp $

DESCRIPTION="advanced replicating networked filesystem"
HOMEPAGE="http://www.inter-mezzo.org/"
SRC_URI="ftp://ftp.inter-mezzo.org/pub/intermezzo/${P/_p/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="net-misc/curl
	media-gfx/transfig
	>=dev-libs/glib-2*
	>=gnome-base/libghttp-1.0.9-r3
	>=sys-kernel/linux-headers-2.4"

S=${WORKDIR}/${P/_p?/}

src_compile() {
	local myconf=""
	has "net-www/apache" \
		&& $myconf="${myconf} --with-apache-modules=/etc/apache/modules"

	econf \
		--localstatedir=/var \
		--libdir=/lib \
		${myconf} \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install
	exeinto /etc/init.d ; newexe ${FILESDIR}/intersync.rc intersync
	insinto /etc/conf.d ; newins ${FILESDIR}/intersync.conf intersync
}
