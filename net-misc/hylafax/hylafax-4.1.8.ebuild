# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hylafax/hylafax-4.1.8.ebuild,v 1.8 2004/07/15 02:53:55 agriffis Exp $

# This is basically unchanged from the one supplied by Stephane Loeuillet
# to Gentoo bug: http://bugs.gentoo.org/show_bug.cgi?id=28574
# Nice job, and thanks :)
# Now with autoreconf for new gcc, and a new gentoo init script.

IUSE="jpeg"

DESCRIPTION="Client-server fax package for class 1 and 2 fax modems."
HOMEPAGE="http://www.hylafax.org"
SRC_URI="ftp://ftp.hylafax.org/source/${P}.tar.gz"

SLOT="0"
LICENSE="hylafax"
KEYWORDS="x86 sparc hppa -alpha -amd64"

DEPEND="net-dialup/mgetty
	>=sys-libs/zlib-1.1.4
	virtual/ghostscript
	>=media-libs/tiff-3.5.5
	jpeg? ( media-libs/jpeg )
	sys-apps/gawk"

RDEPEND="${DEPEND}"

src_compile() {
	# no 'econf' here because does not support standard --prefix option (prehistoric autoconf v1.92 used !!!)
	autoreconf -f
	./configure \
		--with-DIR_BIN=/usr/bin \
		--with-DIR_SBIN=/usr/sbin \
		--with-DIR_LIB=/usr/lib \
		--with-DIR_LIBEXEC=/usr/sbin \
		--with-DIR_LIBDATA=/usr/lib/fax \
		--with-DIR_LOCKS=/var/lock \
		--with-DIR_MAN=/usr/share/man \
		--with-DIR_SPOOL=/var/spool/fax \
		--with-AFM=no \
		--with-AWK=/usr/bin/gawk \
		--with-PATH_VGETTY=/sbin/vgetty \
		--with-PATH_GETTY=/sbin/agetty \
		--with-HTML=no \
		--with-PATH_DPSRIP=/var/spool/fax/bin/ps2fax \
		--with-PATH_IMPRIP=/usr/share/fax/psrip \
		--with-SYSVINIT=/etc/init.d \
		--with-INTERACTIVE=no \
		--with-OPTIMIZER="${CFLAGS}" || die
	# no 'emake' for the same reason (might use an old automake version)
	make || die
}

src_install() {

	dodir /usr/{bin,sbin} /usr/lib/fax /usr/share/man \
		/var/spool/fax/{archive,client,pollq,recvq,tmp}
	chown -R uucp:uucp ${D}/var/spool/fax

	make \
		BIN=${D}/usr/bin \
		SBIN=${D}/usr/sbin \
		LIBDIR=${D}/usr/lib \
		LIB=${D}/usr/lib \
		LIBEXEC=${D}/usr/sbin \
		LIBDATA=${D}/usr/lib/fax \
		MAN=${D}/usr/share/man \
		SPOOL=${D}/var/spool/fax \
		install || die

	insinto /etc/init.d
	insopts -m 755
	doins ${FILESDIR}/hylafax

	dodoc COPYRIGHT README TODO VERSION

	dohtml -r html/
}
