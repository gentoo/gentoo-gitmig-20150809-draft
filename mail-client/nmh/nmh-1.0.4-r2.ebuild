# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/nmh/nmh-1.0.4-r2.ebuild,v 1.5 2004/07/14 16:24:43 agriffis Exp $

DESCRIPTION="New MH mail reader"
SRC_URI="ftp://ftp.mhost.com/pub/nmh/${P}.tar.gz"
HOMEPAGE="http://www.mhost.com/nmh/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc ~ppc"
IUSE=""

DEPEND="virtual/libc
	=sys-libs/db-1.85*
	>=sys-libs/ncurses-5.2
	app-editors/vi"

# Without a valid /usr/bin/vi, the following sandbox violation is produced:
#
# --------------------------- ACCESS VIOLATION SUMMARY ---------------------------
# LOG FILE = "/tmp/sandbox-nmh-1.0.4-r2-9221.log"
#
# open_wr:   /.nonexist-file.swp
# open_wr:   /.nonexist-file.swp
# open_wr:   /root/tmp/nonexist-file.swp
# open_wr:   /root/tmp/nonexist-file.swp
# --------------------------------------------------------------------------------
#
# Thus I am making vi a DEPEND until somebody with more time can figure out a
# better way of fixing this.  NOTE:  /usr/bin/vi being a symlink to /usr/bin/vim
# also fixes this problem.


src_compile() {
	[ -z "${EDITOR}" ] && export EDITOR="/usr/bin/vi"
	[ -z "${PAGER}" ] && export PAGER="/usr/bin/more"

	# Redifining libdir to be bindir so the support binaries get installed
	# correctly.  Since no libraries are installed with nmh, this does not
	# pose a problem at this time.
	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--with-editor=${EDITOR} \
		--with-pager=${PAGER} \
		--enable-nmh-pop \
		--sysconfdir=/etc/nmh \
		--libdir=/usr/bin || die
	make || die
}

src_install() {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		libdir=${D}/usr/bin \
		etcdir=${D}/etc/nmh install || die
	dodoc COMPLETION-TCSH COMPLETION-ZSH TODO FAQ DIFFERENCES \
		MAIL.FILTERING Changelog* COPYRIGHT
}
