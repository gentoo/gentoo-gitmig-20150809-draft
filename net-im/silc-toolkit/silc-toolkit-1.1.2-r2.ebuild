# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/silc-toolkit/silc-toolkit-1.1.2-r2.ebuild,v 1.5 2007/08/15 21:22:52 dertobi123 Exp $

inherit eutils

DESCRIPTION="SDK for the SILC protocol"
HOMEPAGE="http://silcnet.org/"
SRC_URI="http://silcnet.org/download/toolkit/sources/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ppc ~ppc64 ~sparc x86"
IUSE="debug ipv6"

RDEPEND=""
DEPEND="dev-util/pkgconfig"

src_unpack() {
	unpack ${A}

	# They have incorrect DESTDIR usage
	sed -i '/\$(srcdir)\/tutorial/s/\$(prefix)/\$(docdir)/' "${S}"/Makefile.{am,in}
	sed -i \
		"s/^\(pkgconfigdir =\) \$(libdir)\/pkgconfig/\1	\/usr\/$(get_libdir)\/pkgconfig/"\
		"${S}"/lib/Makefile.{am,in}
}

src_compile() {
	local myconf=""
	use ipv6 && myconf="${myconf} --enable-ipv6"

	econf \
		--datadir=/usr/share/${PN} \
		--datarootdir=/usr/share/${PN} \
		--mandir=/usr/share/man \
		--includedir=/usr/include/${PN} \
		--sysconfdir=/etc/silc \
		--with-helpdir=/usr/share/${PN}/help \
		--libdir=/usr/$(get_libdir)/${PN} \
		--docdir=/usr/share/doc/${PF} \
		--disable-optimizations \
		$(use_enable debug) \
		${myconf}

	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"

	rm -rf \
		"${D}"/etc/${PN}/silcd.conf \
		"${D}"/usr/share/man \
		"${D}"/usr/share/doc/${PF}/examples \
		"${D}"/usr/share/silc-toolkit \
		"${D}"/var/log/silc-toolkit \
		"${D}"/etc/silc
}
