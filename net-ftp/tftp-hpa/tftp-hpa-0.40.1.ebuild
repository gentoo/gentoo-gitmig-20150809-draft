# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/tftp-hpa/tftp-hpa-0.40.1.ebuild,v 1.7 2006/10/21 18:46:04 dertobi123 Exp $

DESCRIPTION="port of the OpenBSD TFTP server"
HOMEPAGE="http://www.kernel.org/pub/software/network/tftp/"
SRC_URI="mirror://kernel/software/network/tftp/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm ~hppa ia64 ~mips ppc ppc64 ~s390 ~sparc ~x86"
IUSE="readline selinux tcpd"

DEPEND="readline? ( sys-libs/readline )
	tcpd? ( sys-apps/tcp-wrappers )
	selinux? ( sec-policy/selinux-tftpd )
	!virtual/tftp"
PROVIDE="virtual/tftp"

src_compile() {
	econf \
		$(use_with tcpd tcpwrappers) \
		$(use_with readline) \
		|| die
	emake || die
}

src_install() {
	make INSTALLROOT="${D}" install || die
	dodoc README* CHANGES

	# iputils installs this
	rm -f "${D}"/usr/share/man/man8/tftpd.8

	newconfd "${FILESDIR}"/in.tftpd.confd in.tftpd
	newinitd "${FILESDIR}"/in.tftpd.rc6 in.tftpd
}
