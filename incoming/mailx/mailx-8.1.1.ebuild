# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

S=${WORKDIR}/${P}.orig
DESCRIPTION="The /bin/mail program, which is used to send mail via shell scripts."
SRC_URI="ftp://ftp.debian.org/debian/pool/main/m/mailx/mailx_8.1.1.orig.tar.gz"
HOMEPAGE="http://www.debian.org"

DEPEND=""

src_unpack() {
	unpack ${A}
	
	cd ${S}
	
	patch -p1 < ${FILESDIR}/${P}.debian.patch || die
        patch -p1 < ${FILESDIR}/${P}.security.patch || die
        patch -p1 < ${FILESDIR}/${P}.nolock.patch || die
        patch -p1 < ${FILESDIR}/${P}.debian2.patch || die
        patch -p1 < ${FILESDIR}/${P}-noroot.patch || die
        patch -p1 < ${FILESDIR}/${P}-version.patch || die
        patch -p1 < ${FILESDIR}/${P}-forbid-shellescape-in-interactive-and-setuid.patch || die
	# It needs to install to /bin/mail (else conflicts with Postfix)
	# Also man pages go to /usr/share/man for FHS compliancy
	patch -p0 <${FILESDIR}/${P}-Makefile.patch || die
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

	# Just make sure the attributes is correct
	cd ${D}
	chmod 755 bin/mail
	chown root.mail bin/mail
}

