# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hylafax/hylafax-4.1.8-r4.ebuild,v 1.6 2005/01/11 15:34:23 kingtaco Exp $

# This was originally contributed by Stephane Loeuillet, via
# Gentoo bug: http://bugs.gentoo.org/show_bug.cgi?id=28574
# Nice job, and thanks :)
# Now with autoreconf for new gcc, and a new gentoo init script.

inherit eutils

IUSE="jpeg"

DESCRIPTION="Client-server fax package for class 1 and 2 fax modems."
HOMEPAGE="http://www.hylafax.org"
SRC_URI="ftp://ftp.hylafax.org/source/${P}.tar.gz"

SLOT="0"
LICENSE="hylafax"
KEYWORDS="x86 sparc hppa ~alpha ~amd64 ~ppc"

DEPEND="net-dialup/mgetty
	>=sys-libs/zlib-1.1.4
	virtual/ghostscript
	>=media-libs/tiff-3.5.5
	jpeg? ( media-libs/jpeg )
	sys-apps/gawk"

RDEPEND="${DEPEND}
	net-mail/metamail"

export CONFIG_PROTECT="${CONFIG_PROTECT} /var/spool/fax/etc"

src_compile() {
	epatch ${FILESDIR}/${P}-gcc-version.patch
	epatch ${FILESDIR}/${P}-fPIC.patch
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
		--with-PS=auto \
		--with-PATH_GSRIP=/usr/bin/gs \
		--with-PATH_DPSRIP=/var/spool/fax/bin/ps2fax \
		--with-PATH_IMPRIP=/usr/share/fax/psrip \
		--with-SYSVINIT=/etc/init.d \
		--with-INTERACTIVE=no \
		--with-LIBTIFF="-ltiff -ljpeg -lz" \
		--with-OPTIMIZER="${CFLAGS}" || die
	# no 'emake' for the same reason (might use an old automake version)
	make || die
}

src_install() {

	dodir /usr/{bin,sbin} /usr/lib/fax /usr/share/man \
		/var/spool/fax/{archive,client,etc,pollq,recvq,tmp}
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

	einfo "Adding env.d entry for Hylafax"
	dodir /etc/env.d
	insinto /etc/env.d
	doins ${FILESDIR}/99hylafax

	keepdir /var/spool/fax/{archive,client,etc,pollq,recvq,tmp}
	keepdir /var/spool/fax/{status,sendq,recvq,log,info,doneq,docq,dev}

	einfo "Adding init.d entry for Hylafax"
	insinto /etc/init.d
	insopts -m 755
	doins ${FILESDIR}/hylafax

	dodoc COPYRIGHT README TODO VERSION

	dohtml -r html/
	keepdir /usr/share/doc/${P}
}

pkg_postinst() {
	ewarn "Proper fax2tiff support now requires libtiff 3.5.5 until there"
	ewarn "is an upstream fix for bug #48077.  You must use this version"
	ewarn "of fax2tiff if you need conversion of G3 files, however, you"
	ewarn "you must still build hylafax against tiff-3.5.7-r1 or better."
	ewarn "I repeat: do not try to build hylafax or anything else against"
	ewarn "tiff-3.5.5 because it won't work.  You've been warned."
}
