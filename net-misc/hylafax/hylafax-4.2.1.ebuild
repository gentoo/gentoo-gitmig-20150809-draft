# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hylafax/hylafax-4.2.1.ebuild,v 1.2 2005/08/12 07:39:45 nerdboy Exp $

inherit eutils

IUSE="faxonly jpeg pam"

DESCRIPTION="Client-server fax package for class 1 and 2 fax modems."
HOMEPAGE="http://www.hylafax.org"
SRC_URI="ftp://ftp.hylafax.org/source/${P}.tar.gz"

SLOT="0"
LICENSE="hylafax"
KEYWORDS="~x86 ~sparc ~hppa ~alpha ~amd64 ~ppc"

DEPEND="!faxonly? ( net-dialup/mgetty )
	>=sys-libs/zlib-1.1.4
	virtual/ghostscript
	>=media-libs/tiff-3.7.0
	jpeg? ( media-libs/jpeg )
	sys-apps/gawk
	pam? ( sys-libs/pam )"

RDEPEND="${DEPEND}
	net-mail/metamail"

export CONFIG_PROTECT="${CONFIG_PROTECT} /var/spool/fax/etc"

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
		--with-OPTIMIZER=\"${CFLAGS}\"
		--with-DSO=auto"

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

	# eval required for quoting in ${my_conf} to work properly, better way?
	eval ./configure --nointeractive ${my_conf} || die "./configure failed"

	emake -j1 || die "emake failed"
}

src_install() {
	dodir /usr/{bin,sbin} /usr/lib/fax /usr/share/man /var/spool /var/spool/recvq
	fowners uucp:uucp /var/spool/fax
	fperms 0600 /var/spool/fax
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

	keepdir /var/spool/fax/{archive,client,etc,pollq,recvq,tmp}
	keepdir /var/spool/fax/{status,sendq,log,info,doneq,docq,dev}

	einfo "Adding env.d entry for Hylafax"
	insinto /etc/env.d
	newins ${FILESDIR}/99hylafax-4.2 99hylafax

	einfo "Adding init.d entry for Hylafax"
	insinto /etc/init.d
	insopts -m 755
	newins ${FILESDIR}/hylafax-4.2 hylafax

	dodoc COPYRIGHT README TODO VERSION
}

pkg_postinst() {
	ewarn "New Hylafax tiff support requires at least tiff-3.7.0 now,"
	ewarn "but hopefully this libtiff silliness is now fixed."
	ewarn "If you have trouble building this brittle C++ code,"
	ewarn "try disabling distcc and setting MAKEOPTS to -j1."
	echo
	einfo "Hylafax is back to depending on metamail for mime handling."
	echo
	einfo "Now run faxsetup and (if necessary) faxaddmodem."
	echo
}
