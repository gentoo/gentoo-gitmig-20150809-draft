# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@saintmail.net>

S=${WORKDIR}/${P}.orig
DESCRIPTION="The /bin/mail program, which is used to send mail via shell scripts."
SRC_URI="ftp://ftp.debian.org/debian/pool/main/m/mailx/mailx_8.1.1.orig.tar.gz"
HOMEPAGE="http://www.debian.org"

DEPEND=">=sys-libs/liblockfile-1.03"

src_unpack() {
	unpack ${A}
	
	cd ${S}
	
        patch -p1 < ${FILESDIR}/${PF}.diff || die
	patch -p1 < ${FILESDIR}/${PF}-version.diff || die
	# It needs to install to /bin/mail (else conflicts with Postfix)
	# Also man pages go to /usr/share/man for FHS compliancy
	patch -p0 <${FILESDIR}/${PF}-Makefile.diff || die
}

src_compile() {
	cd ${S}
	
	# Can't compile mailx with optimizations
	_CFLAGS=$(echo $CFLAGS|sed 's/-O.//g')
	
	make CFLAGS="$_CFLAGS" || die
}

src_install () {
	cd ${S}
	
	dodir /bin /usr/share/man/man1 /etc /usr/lib
	make BINDIR=/bin DESTDIR=${D} install || die

	# Create symlinks (some scripts require Mail)
	cd ${D}/bin
	ln -sf mail Mail
	cd ${D}/usr/share/man/man1
	ln -sf mail.1 Mail.1
}

