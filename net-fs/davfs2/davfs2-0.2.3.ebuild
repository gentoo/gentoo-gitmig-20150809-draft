# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/davfs2/davfs2-0.2.3.ebuild,v 1.3 2004/11/27 22:12:02 genstef Exp $

inherit kernel-mod eutils

IUSE="ssl debug"

DESCRIPTION="a Linux file system driver that allows you to mount a WebDAV server as a local disk drive. Davfs2 uses Coda for kernel driver and neon for WebDAV interface"
SRC_URI="mirror://sourceforge/dav/${P}.tar.gz"
HOMEPAGE="http://dav.sourceforge.net"
KEYWORDS="~x86 ~ppc"

LICENSE="GPL-2"
DEPEND="ssl? ( >=dev-libs/openssl-0.9.6 )
		dev-libs/libxml2
		sys-libs/zlib"
SLOT="0"

pkg_setup() {
	if ! kernel-mod_configoption_present CODA_FS
	then
		eerror
		eerror "You need coda kernel support in /usr/src/linux/.config"
		eerror "Coda can be found in filesystems, network filesystems"
		eerror
		die
	fi

}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}.nokernelsrc.patch
}

src_compile() {
	econf $(use_with ssl) \
		$(use_with debug) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"

	dodoc BUGS ChangeLog FAQ README THANKS TODO

	dodir /etc/modules.d
	cat >${D}/etc/modules.d/davfs2 <<EOF
alias char-major-67	coda
alias /dev/davfs*	coda
EOF
}

pkg_postinst() {
	if [ -x /sbin/modules-update ] ;
	then
		ebegin "Updating modules.conf"
		/sbin/modules-update
		eend $?
	fi
}
