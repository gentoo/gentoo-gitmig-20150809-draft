# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/chrony/chrony-1.24-r2.ebuild,v 1.6 2010/09/18 16:16:42 armin76 Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="NTP client and server programs"
HOMEPAGE="http://chrony.tuxfamily.org/"
SRC_URI="http://download.tuxfamily.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~mips ~ppc sparc x86"
IUSE="caps readline"

RDEPEND="
	readline? ( >=sys-libs/readline-4.1-r4 )
	caps? ( sys-libs/libcap )
"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.21-hppa.patch
	sed -i "s:/etc/chrony\.:/etc/chrony/chrony.:g" \
		examples/* chrony*.{1,5,8} faq.txt chrony.texi || die "sed failed"
}

src_configure() {
	tc-export CC
	local myconf
	use readline || myconf+=" --disable-readline"
	#use ipv6     || myconf+=" --disable-ipv6"
	use caps     || myconf+=" --disable-linuxcaps"
	# selfwritten configure
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc/chrony \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--docdir=/usr/share/doc/${PF} \
		${myconf} ${EXTRA_ECONF} || die "configure failed"
}

src_compile() {
	emake all || die "make failed"
	emake docs || die "make docs failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	rm "${D}"/usr/share/doc/${PF}/COPYING || die
	dodoc examples/chrony.{conf,keys}.example || die
	doinfo chrony.info* || die

	newinitd "${FILESDIR}"/chronyd.rc chronyd || die
	dosed "s:the documentation directory:/usr/share/doc/${PF}/:" \
		/etc/init.d/chronyd || die "doc sed failed"
	newconfd "${FILESDIR}"/chronyd.conf chronyd || die

	keepdir /var/{lib,log}/chrony /etc/chrony

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/chrony.logrotate chrony
}
