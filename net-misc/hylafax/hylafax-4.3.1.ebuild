# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hylafax/hylafax-4.3.1.ebuild,v 1.6 2007/08/24 03:42:26 nerdboy Exp $

inherit eutils multilib pam flag-o-matic toolchain-funcs

IUSE="faxonly jbig pam mgetty html"

DESCRIPTION="Client-server fax package for class 1 and 2 fax modems."
HOMEPAGE="http://www.hylafax.org"
SRC_URI="ftp://ftp.hylafax.org/source/${P}.tar.gz"

SLOT="0"
LICENSE="hylafax"
KEYWORDS="~x86 ~sparc ~hppa ~amd64 ~ppc"

DEPEND="!faxonly? ( net-dialup/mgetty )
	>=sys-libs/zlib-1.1.4
	virtual/ghostscript
	>=media-libs/tiff-3.8.2
	media-libs/jpeg
	jbig? ( media-libs/jbigkit )
	sys-apps/gawk
	pam? ( virtual/pam )
	mgetty? ( net-dialup/mgetty )"

RDEPEND="${DEPEND}
	net-mail/metamail"

export CONFIG_PROTECT="${CONFIG_PROTECT} /var/spool/fax/etc /usr/lib/fax"

src_compile() {
	if use faxonly; then
		if use mgetty; then
			eerror "You cannot set both faxonly and mgetty, please remove one." && die "invalid use flags"
		fi
	fi
	if use jbig; then
		einfo       "Checking for tiff compiled with jbig support..."
		if built_with_use media-libs/tiff jbig; then
			einfo "Found jbig support; continuing..."
		else
			ewarn "Tiff (media-libs/tiff) must be compiled with jbig support."
			einfo "Please re-emerge tiff with the jbig USE flag or disable it."
			die "Tiff not merged with jbig USE flag"
		fi
	fi

	# Hylafax doesn't play nice with gcc-3.4 and SSP (bug #74457)
	# so drop the flags until a better solution comes along
	[ $(gcc-major-version) -eq 3 ] && [ $(gcc-minor-version) -ge 4 ] \
		&& filter-flags -fstack-protector -fstack-protector-all

	epatch ${FILESDIR}/gentoo-gcc-version.patch || die "epatch failed"

	local my_conf="
		--with-DIR_BIN=/usr/bin
		--with-DIR_SBIN=/usr/sbin
		--with-DIR_LIB=/usr/$(get_libdir)
		--with-DIR_LIBEXEC=/usr/sbin
		--with-DIR_LIBDATA=/usr/$(get_libdir)/fax
		--with-DIR_LOCKS=/var/lock
		--with-DIR_MAN=/usr/share/man
		--with-DIR_SPOOL=/var/spool/fax
		--with-DIR_HTML=/usr/share/doc/${P}/html
		--with-DIR_CGI=${WORKDIR}
		--with-PATH_DPSRIP=/var/spool/fax/bin/ps2fax
		--with-PATH_IMPRIP=\"\"
		--with-SYSVINIT=no
		--with-REGEX=yes
		--with-LIBTIFF=\"-ltiff -ljpeg -lz\"
		--with-OPTIMIZER=\"${CFLAGS}\"
		--with-DSO=auto"

	if use html; then
		my_conf="${my_conf} --with-HTML=yes"
	else
		my_conf="${my_conf} --with-HTML=no"
	fi

	if use mgetty; then
		my_conf="${my_conf} \
			--with-PATH_EGETTY=/sbin/mgetty \
			--with-PATH_VGETTY=/usr/sbin/vgetty"
	else
		my_conf="${my_conf} \
			--with-PATH_EGETTY=/bin/false \
			--with-PATH_VGETTY=/bin/false"
	fi

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

	myconf="CC=$(tc-getCC) CXX=$(tc-getCXX) ${my_conf}"

	# eval required for quoting in ${my_conf} to work properly, better way?
	eval ./configure --nointeractive ${my_conf} || die "./configure failed"

	emake -j1 || die "emake failed"
}

src_install() {
	dodir /usr/{bin,sbin} /usr/$(get_libdir)/fax /usr/share/man
	dodir /var/spool /var/spool/recvq
	fowners uucp:uucp /var/spool/fax
	fperms 0600 /var/spool/fax
	dodir /usr/share/doc/${P}/html

	make \
		BIN=${D}/usr/bin \
		SBIN=${D}/usr/sbin \
		LIBDIR=${D}/usr/$(get_libdir) \
		LIB=${D}/usr/$(get_libdir) \
		LIBEXEC=${D}/usr/sbin \
		LIBDATA=${D}/usr/$(get_libdir)/fax \
		MAN=${D}/usr/share/man \
		SPOOL=${D}/var/spool/fax \
		HTMLDIR=${D}/usr/share/doc/${P}/html \
		install || die "make install failed"

	keepdir /var/spool/fax/{archive,client,etc,pollq,recvq,tmp}
	keepdir /var/spool/fax/{status,sendq,log,info,doneq,docq,dev}

	dosed "s:hostname:hostname -f:g" \
	    /var/spool/fax/bin/{faxrcvd,pollrcvd} || die "dosed failed"

	einfo "Adding env.d entry for Hylafax"
	newenvd ${FILESDIR}/99hylafax-4.2 99hylafax

	einfo "Adding init.d entry for Hylafax"
	newinitd ${FILESDIR}/hylafax-4.2 hylafax

	use pam && pamd_mimic_system hylafax auth account session

	dodoc CHANGES CONTRIBUTORS COPYRIGHT README TODO
}

pkg_postinst() {
	elog
	elog "There are additional files included in the hylafax/files dir."
	elog
	elog "Note 1: hylafax.cron is provided for vixie-cron users and"
	elog "should be placed in /etc/cron.d.  Use as-is or adapt it to"
	elog "your system config."
	elog
	elog "Note 2: if you need to use hylafax with iptables, then you"
	elog "need to specify the port and use ip_conntrack_ftp as shown"
	elog "in the included example modules file."
	elog
	elog "See the docs and man pages for detailed configuration info."
	elog
	elog "Now run faxsetup and (if necessary) faxaddmodem."
	elog
}
