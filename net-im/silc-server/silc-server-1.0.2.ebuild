# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/silc-server/silc-server-1.0.2.ebuild,v 1.5 2006/12/28 17:31:21 gustavoz Exp $

inherit eutils autotools

DESCRIPTION="Server for Secure Internet Live Conferencing"
SRC_URI="http://www.silcnet.org/download/server/sources/${P}.tar.bz2"
HOMEPAGE="http://silcnet.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc sparc x86"
IUSE="ipv6 debug"

RDEPEND="!<=net-im/silc-toolkit-0.9.12-r1
	!<=net-im/silc-client-1.0.1"
DEPEND="${RDEPEND}
	=sys-devel/automake-1.9*"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/1.0-fPIC.patch

	eautoreconf
}

src_compile() {
	econf \
		--sysconfdir=/etc/silc \
		--with-docdir=/usr/share/doc/${PF} \
		--with-helpdir=/usr/share/${PN}/help \
		--with-logsdir=/var/log/${PN} \
		--with-mandir=/usr/share/man \
		--with-silcd-pid-file=/var/run/silcd.pid \
		--with-simdir=/usr/$(get_libdir)/${PN} \
		--without-silc-libs \
		$(use_enable ipv6) \
		$(use_enable debug) \
		|| die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	insinto /usr/share/doc/${PF}/examples
	doins doc/examples/*.conf

	fperms 600 /etc/silc
	keepdir /var/log/${PN}

	rm -rf \
		"${D}"/usr/libsilc* \
		"${D}"/usr/include \
		"${D}"/etc/silc/silcd.{pub,prv}

	newinitd "${FILESDIR}/silcd.initd" silcd

	sed -i \
		-e 's:10.2.1.6:0.0.0.0:' \
		-e 's:User = "nobody";:User = "silcd";:' \
		"${D}"/etc/silc/silcd.conf
}

pkg_postinst() {
	enewuser silcd

	if [ ! -f "${ROOT}"/etc/silc/silcd.prv ] ; then
		einfo "Creating key pair in /etc/silc"
		silcd -C "${ROOT}"/etc/silc
	fi
}
