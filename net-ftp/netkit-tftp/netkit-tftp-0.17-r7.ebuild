# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/netkit-tftp/netkit-tftp-0.17-r7.ebuild,v 1.8 2011/03/22 14:52:50 pva Exp $

inherit eutils toolchain-funcs

DESCRIPTION="the tftp server included in netkit"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/netkit-tftp-0.17.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 hppa ~mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="!virtual/tftp
	virtual/inetd"

src_unpack() {
	unpack ${A}
	cd "${S}"

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
}

src_compile() {
	./configure \
		--prefix=/usr \
		--installroot="${D}" \
		--with-c-compiler="$(tc-getCC)" \
		|| die
	emake || die
}

src_install() {
	dodir /usr/bin /usr/sbin /usr/share/man/man{1,8}
	emake install || die
	rm -f "${D}"/usr/share/man/man8/tftpd.8 #214734, collision with iputils
	insinto /etc/xinetd.d
	doins "${FILESDIR}"/{tftp-dgram,tftp-stream}
	dodoc BUGS ChangeLog README
}
