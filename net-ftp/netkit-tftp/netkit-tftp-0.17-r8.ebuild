# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/netkit-tftp/netkit-tftp-0.17-r8.ebuild,v 1.2 2012/07/22 20:26:46 vapier Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="the tftp server included in netkit"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="virtual/inetd"
RDEPEND="!net-ftp/atftp
	!net-ftp/tftp-hpa
	${DEPEND}"

src_prepare() {
	# Change default man directory
	sed -i \
		-e 's:MANDIR="$PREFIX/man":MANDIR="$PREFIX/share/man":' \
		-e 's:^LDFLAGS=::' \
		configure

	# don't prestrip binaries
	find . -name Makefile -print0 | xargs -0 sed -i -e 's:install -s:install:'

	# Solve QA warning by including string.h
	epatch "${FILESDIR}"/memset.patch
	epatch "${FILESDIR}"/${P}-tftp-connect-segfault.patch
	epatch "${FILESDIR}"/${P}-tftp-manpage-typo.patch
	epatch "${FILESDIR}"/${P}-tftp-fix-put-zero-size.diff
	epatch "${FILESDIR}"/${P}-tftpd-put-fixes.patch
	epatch "${FILESDIR}"/${P}-socket-reopen-on-errors.patch
	rm include/arpa/tftp.h || die #425184
}

src_configure() {
	./configure \
		--prefix=/usr \
		--installroot="${D}" \
		--with-c-compiler="$(tc-getCC)" \
		|| die
}

src_install() {
	dodir /usr/bin /usr/sbin /usr/share/man/man{1,8}
	emake install || die
	rm -f "${D}"/usr/share/man/man8/tftpd.8 #214734, collision with iputils
	insinto /etc/xinetd.d
	doins "${FILESDIR}"/{tftp-dgram,tftp-stream}
	dodoc BUGS ChangeLog README
}
