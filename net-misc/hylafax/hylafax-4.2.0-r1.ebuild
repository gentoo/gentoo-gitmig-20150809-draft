# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hylafax/hylafax-4.2.0-r1.ebuild,v 1.4 2004/12/04 08:46:37 nerdboy Exp $

inherit eutils

IUSE="faxonly jpeg pam"

DESCRIPTION="Client-server fax package for class 1 and 2 fax modems."
HOMEPAGE="http://www.hylafax.org"
SRC_URI="ftp://ftp.hylafax.org/source/${P}.tar.gz"

SLOT="0"
LICENSE="hylafax"
KEYWORDS="x86 sparc ~hppa ~alpha ~amd64 ~ppc"

DEPEND="!faxonly? ( net-dialup/mgetty )
	>=sys-libs/zlib-1.1.4
	virtual/ghostscript
	>=media-libs/tiff-3.7.0
	jpeg? ( media-libs/jpeg )
	sys-apps/gawk
	pam? ( sys-libs/pam )"

RDEPEND="${DEPEND}
	app-arch/sharutils"

export CONFIG_PROTECT="${CONFIG_PROTECT} /var/spool/fax/etc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-faxcron_uid.patch
	epatch ${FILESDIR}/${P}-tiff_version.patch
	epatch ${FILESDIR}/configure-gcc-3.4.patch
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
	ewarn "New Hylafax tiff support requires tiff-3.7.0 now,"
	ewarn "but hopefully this libtiff silliness is now fixed."
	echo
	einfo "Hylafax now depends on sharutils instead of metamail for mime"
	einfo "handling, however, you can continue to use the latter if you"
	einfo "like (emerge metamail manually)."
	echo
	einfo "Now run faxsetup and (if necessary) faxaddmodem."
	echo
}
