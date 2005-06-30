# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/netatalk/netatalk-2.0.3.ebuild,v 1.1 2005/06/30 23:56:56 flameeyes Exp $

inherit eutils pam
IUSE="ssl pam tcpd slp cups kerberos krb4 afs debug cracklib"

DESCRIPTION="kernel level implementation of the AppleTalk Protocol Suite"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://netatalk.sourceforge.net"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=sys-libs/db-4.2.52
	cracklib? ( sys-libs/cracklib )
	pam? ( virtual/pam )
	ssl? ( dev-libs/openssl )
	tcpd? ( sys-apps/tcp-wrappers )
	slp? ( net-libs/openslp )
	cups? ( net-print/cups )
	afs? ( net-fs/openafs )
	kerberos? ( virtual/krb5 )
	krb4? ( virtual/krb5 )"

src_unpack() {
	unpack ${A}
	cd ${S}

	# until someone that understands their config script build
	# system gets a patch pushed upstream to make
	# --enable-srvloc passed to configure also add slpd to the
	# use line on the initscript, we'll need to do it this way
	if use slp; then
		myconf="${myconf} --enable-srvloc"
		sed -i -e 's/^\([[:space:]]*use[[:space:][:alnum:]]*\)$/\1 slpd/' \
			${S}/distrib/initscripts/rc.atalk.gentoo.tmpl
	fi

	# This is a fix to add -z,now to the linkflags for libraries
	sed -i -e 's/^\([[:space:]]\+\)\(-D_PATH_AFP.*\)/\1-Wl,-z,now \2/' ${S}/bin/afppasswd/Makefile.in
}

src_compile() {
	# Ignore --enable-gentoo, we install the init.d by hand and we avoid having to
	# sed the Makefiles to not do rc-update.
	econf \
		$(use_with pam) \
		$(use_enable afs) \
		$(use_enable cups) \
		$(use_enable ssl) \
		$(use_enable debug) \
		$(use_enable tcpd tcp-wrappers) \
		$(use_enable kerberos krbV-uam) \
		$(use_enable krb4 krb4-uam) \
		$(use_enable slp srvloc) \
		$(use_with cracklib) \
		$(use_with elibc_glibc shadow) \
		--enable-fhs \
		--with-bdb=/usr \
		${myconf} || die "netatalk configure failed"

	emake || die "netatalk emake failed"

	# Create the init script manually (it's more messy to --enable-gentoo)
	cd ${S}/distrib/initscripts
	emake rc.atalk.gentoo
}

src_install() {
	make DESTDIR=${D} install || die "netatalk make install failed"

	dodoc CONTRIBUTORS NEWS README TODO VERSION

	newinitd ${S}/distrib/initscripts/rc.atalk.gentoo atalk

	# The pamd file isn't what we need, use pamd_mimic_system
	rm -rf ${D}/etc/pam.d
	pamd_mimic_system netatalk auth account password session
}
