# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hylafax/hylafax-4.2.0_rc2.ebuild,v 1.1 2004/08/10 04:15:54 nerdboy Exp $

# New modified 4.2 ebuild contributed by stan <stan@saticed.me.uk>
# Gentoo bug: http://bugs.gentoo.org/show_bug.cgi?id=59766
# Nice job, and thanks :)

inherit eutils

IUSE="faxonly jpeg pam"

DESCRIPTION="Client-server fax package for class 1 and 2 fax modems."
HOMEPAGE="http://www.hylafax.org"
SRC_URI="ftp://ftp.hylafax.org/source/BETA/${P/_/}.tar.gz"

SLOT="0"
LICENSE="hylafax"
KEYWORDS="~x86 ~sparc ~hppa ~alpha ~amd64 ~ppc"

DEPEND="!faxonly? ( net-dialup/mgetty )
	>=sys-libs/zlib-1.1.4
	virtual/ghostscript
	>=media-libs/tiff-3.5.5
	jpeg? ( media-libs/jpeg )
	sys-apps/gawk
	pam? ( sys-libs/pam )"

RDEPEND="${DEPEND}
	net-mail/metamail"

export CONFIG_PROTECT="${CONFIG_PROTECT} /var/spool/fax/etc"

S=${WORKDIR}/${P/_/}

src_unpack() {
	unpack ${A}
	echo "\${OBJECTS}: GC++OPTS+=-fpic" >> ${S}/util/Makefile.LINUXdso
	echo "\${SERVER_OBJS}: GC++OPTS+=-fpic" >> ${S}/faxd/Makefile.LINUXdso
	echo "\${MODEM_OBJS}: GC++OPTS+=-fpic" >> ${S}/faxd/Makefile.LINUXdso
}

src_compile() {
	local my_conf="
		--with-DIR_BIN=/usr/bin
		--with-DIR_SBIN=/usr/sbin
		--with-DIR_LIB=/usr/lib
		--with-DIR_LIBEXEC=/usr/sbin
		--with-DIR_LIBDATA=/usr/lib/fax
		--with-DIR_LOCKS=/var/lock
		--with-DIR_MAN=/usr/share/man
		--with-DIR_SPOOL=/var/spool/fax
		--with-DIR_HTML=/usr/share/doc/${P}/html
		--with-DIR_CGI=${WORKDIR}
		--with-PATH_EGETTY=/bin/false
		--with-HTML=yes
		--with-PATH_DPSRIP=/var/spool/fax/bin/ps2fax
		--with-PATH_IMPRIP=\"\"
		--with-SYSVINIT=no
		--with-LIBTIFF=\"-ltiff -ljpeg -lz\"
		--with-OPTIMIZER=\"${CFLAGS}\""

	if [ -h /etc/localtime ]; then
		local continent=$(readlink /etc/localtime | cut -d / -f 5)
		if [ "${continent}" == "Europe" ]; then
			my_conf="${my_conf} --with-PAGESIZE=A4"
		fi
	fi

	use faxonly && my_conf="${my_conf} --with-PATH_GETTY=/bin/false
	                                  --with-PATH_VGETTY=/bin/false"
	#--enable-pam isn't valid
	use pam || my_conf="${my_conf} $(use_enable pam)"

	# no 'econf' here because custom configure script used
	eval ./configure --nointeractive ${my_conf} || die "./configure failed"

	emake -j1 || die "emake failed"
}

src_install() {
	dodir /usr/{bin,sbin} /usr/lib/fax /usr/share/man /var/spool
	dodir /usr/share/doc/${P}/html

	make \
		BIN=${D}/usr/bin \
		SBIN=${D}/usr/sbin \
		LIBDIR=${D}/usr/lib \
		LIB=${D}/usr/lib \
		LIBEXEC=${D}/usr/sbin \
		LIBDATA=${D}/usr/lib/fax \
		MAN=${D}/usr/share/man \
		SPOOL=${D}/var/spool/fax \
		HTMLDIR=${D}/usr/share/doc/${P}/html \
		install || die "make install failed"

	keepdir /var/spool/fax/{archive,client,pollq,tmp}

	einfo "Adding env.d entry for Hylafax"
	insinto /etc/env.d
	newins ${FILESDIR}/99hylafax-4.2 hylafax

	einfo "Adding init.d entry for Hylafax"
	insinto /etc/init.d
	insopts -m 755
	newins ${FILESDIR}/hylafax-4.2 hylafax

	dodoc COPYRIGHT README TODO VERSION
}

pkg_postinst() {
	ewarn "Proper fax2tiff support now requires libtiff 3.5.5 until there"
	ewarn "is an upstream fix for bug #48077.  You must use this version"
	ewarn "of fax2tiff if you need conversion of G3 files, however, you"
	ewarn "you must still build hylafax against tiff-3.5.7-r1 or better."
	ewarn "I repeat: do not try to build hylafax or anything else against"
	ewarn "tiff-3.5.5 because it won't work.  You've been warned."
	echo
	einfo "Now run faxsetup"
	echo
}
