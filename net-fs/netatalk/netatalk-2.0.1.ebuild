# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/netatalk/netatalk-2.0.1.ebuild,v 1.2 2004/12/12 21:52:24 rphillips Exp $

inherit eutils flag-o-matic
IUSE="ssl pam tcpd slp cups kerberos krb4 afs debug"

DESCRIPTION="kernel level implementation of the AppleTalk Protocol Suite"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://netatalk.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

RDEPEND="sys-apps/shadow
	sys-libs/cracklib
	pam? ( sys-libs/pam )
	ssl? ( dev-libs/openssl )
	tcpd? ( sys-apps/tcp-wrappers )
	slp? ( net-libs/openslp )
	cups? ( net-print/cups )
	afs? ( net-fs/openafs )
	kerberos? ( virtual/krb5 )
	krb4? ( virtual/krb5 )"

DEPEND="${RDEPEND}
	sys-apps/sed"

src_compile() {
	# Done this way because this configure script uses odd
	# names for these.
	# -AD Rutledge
	!(use tcpd) && myconf="${myconf} --disable-tcp-wrappers"
	use kerberos && myconf="${myconf} --enable-krbV-uam"
	use krb4 && myconf="${myconf} --enable-krb4-uam"

	# until someone that understands their config script build
	# system gets a patch pushed upstream to make
	# --enable-srvloc passed to configure also add slpd to the
	# use line on the initscript, we'll need to do it this way
	# -AD Rutledge
	if use slp; then
		myconf="${myconf} --enable-srvloc"
		sed -i -e 's/^\([[:space:]]*use[[:space:][:alnum:]]*\)$/\1 slpd/' \
			${S}/distrib/initscripts/rc.atalk.gentoo.tmpl
	fi

	# This is a fix to add -z,now to the linkflags for libraries and 
	# to stop the braindead makefiles upstream hands us from running
	# rc-update and causing an access violation
	sed -i -e 's/^\(@USE_GENTOO_TRUE@[[:space:]]\+-rc-update add atalk default[[:space:]]*\)/#\1/' \
		${S}/distrib/initscripts/Makefile.in
	sed -i -e 's/^\([[:space:]]\+\)\(-D_PATH_AFP.*\)/\1-Wl,-z,now \2/' ${S}/bin/afppasswd/Makefile.in

	econf \
		$(use_with pam) \
		$(use_enable afs) \
		$(use_enable cups) \
		$(use_enable ssl) \
		$(use_enable debug) \
		--with-cracklib \
		--enable-fhs \
		--with-shadow \
		--with-bdb=/usr \
		--enable-gentoo \
		${myconf} || die "netatalk configure failed"

	# This is a fix for the very nasty behavior of running rc-update
	# in the Makefile.
	sed -i -e 's/^\([[:space:]\t]*-rc-update add atalk default[[:space:]\t]*\)/#\1/' \
		${S}/distrib/initscripts/Makefile

	emake || die "netatalk emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "netatalk make install failed"

	# install docs
	dodoc CONTRIBUTORS
	dodoc NEWS README TODO VERSION

	# install init script
	doinitd ${S}/distrib/initscripts/atalk
}
