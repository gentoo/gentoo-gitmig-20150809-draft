# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/silc-toolkit/silc-toolkit-1.0.ebuild,v 1.10 2005/08/24 23:41:35 agriffis Exp $

inherit eutils flag-o-matic

DESCRIPTION="SDK for the SILC protocol"
HOMEPAGE="http://silcnet.org/"
SRC_URI="http://silcnet.org/download/toolkit/sources/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE="debug ipv6"

RDEPEND="!<=net-im/silc-client-1.0.1"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}

	# They have incorrect DESTDIR usage
	sed -i '/\$(srcdir)\/tutorial/s/\$(prefix)/\$(docdir)/' ${S}/Makefile.am
	sed -i '/\$(srcdir)\/tutorial/s/\$(prefix)/\$(docdir)/' ${S}/Makefile.in

	# Stop them from unsetting our CFLAGS
	sed -i '/^CFLAGS=$/d' ${S}/configure || die
}

src_compile() {
	econf \
		--datadir=/usr/share/${PN} \
		--mandir=/usr/share/man \
		--includedir=/usr/include/${PN} \
		--with-etcdir=/etc/silc \
		--with-helpdir=/usr/share/${PN}/help \
		--with-simdir=/usr/$(get_libdir)/${PN} \
		--with-docdir=/usr/share/doc/${PF} \
		--with-logsdir=/var/log/${PN} \
		--enable-shared \
		--enable-static \
		$(use_enable debug) \
		$(use_enable ipv6)

	emake || die "emake failed"
	emake -C lib || die "emake -C lib failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"

	rm -rf \
		${D}/etc/${PN}/silcd.conf \
		${D}/usr/share/man \
		${D}/usr/share/doc/${PF}/examples \
		${D}/usr/share/silc-toolkit \
		${D}/var/log/silc-toolkit \
		${D}/etc/silc
}
