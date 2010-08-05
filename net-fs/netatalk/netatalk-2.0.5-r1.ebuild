# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/netatalk/netatalk-2.0.5-r1.ebuild,v 1.8 2010/08/05 17:18:27 ssuominen Exp $

EAPI=2

inherit eutils pam

DESCRIPTION="Kernel level implementation of the AppleTalk Protocol Suite"
HOMEPAGE="http://netatalk.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="cracklib cups debug kerberos pam slp ssl tcpd xfs"

RDEPEND=">=sys-libs/db-4.2.52
	cracklib? ( sys-libs/cracklib )
	pam? ( virtual/pam )
	ssl? ( dev-libs/openssl )
	tcpd? ( sys-apps/tcp-wrappers )
	slp? ( net-libs/openslp )
	cups? ( net-print/cups )
	kerberos? ( virtual/krb5 )
	>=sys-apps/coreutils-7.1
	!app-text/yudit"
DEPEND="${RDEPEND}
	xfs? ( sys-fs/xfsprogs <sys-kernel/linux-headers-2.6.16 )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-control-pam.patch

	# until someone that understands their config script build
	# system gets a patch pushed upstream to make
	# --enable-srvloc passed to configure also add slpd to the
	# use line on the initscript, we'll need to do it this way
	if use slp ; then
		sed -i -e '/^[[:space:]]*use\>/s:$: slpd:' \
			distrib/initscripts/rc.atalk.gentoo.tmpl || die
	fi
}

src_configure() {
	if ! use xfs ; then
		eval $(printf '%s\n' {linux,xfs}/{dqblk_xfs,libxfs,xqm,xfs_fs}.h | \
			sed -e 's:[/.]:_:g' -e 's:^:export ac_cv_header_:' -e 's:$:=no:')
	fi

	# Ignore --enable-gentoo, we install the init.d by hand and we avoid having
	# to sed the Makefiles to not do rc-update.
	# --enable-shadow: let build system detect shadow.h in toolchain
	econf \
		$(use_with pam) \
		$(use_enable cups) \
		$(use_enable debug) \
		$(use_enable tcpd tcp-wrappers) \
		$(use_enable kerberos krbV-uam) \
		--disable-krb4-uam \
		$(use_enable slp srvloc) \
		$(use_with ssl ssl-dir) \
		$(use_with cracklib) \
		$(use_with slp srvloc) \
		--disable-afs \
		--enable-fhs \
		--with-bdb=/usr
}

src_compile() {
	emake || die

	# Create the init script manually (it's more messy to --enable-gentoo)
	emake -C distrib/initscripts rc.atalk.gentoo || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc CONTRIBUTORS NEWS README TODO VERSION

	newinitd distrib/initscripts/rc.atalk.gentoo atalk || die

	# The pamd file isn't what we need, use pamd_mimic_system
	rm -rf "${D}/etc/pam.d"
	pamd_mimic_system netatalk auth account password session

	# Move /usr/include/netatalk to /usr/include/netatalk2 to avoid collisions
	# with /usr/include/netatalk/at.h provided by glibc (strange, uh?)
	# Packages that wants to link to netatalk should then probably change the
	# includepath then, but right now, nothing uses netatalk.
	# On a side note, it also solves collisions with freebsd-lib and other libcs
	mv "${D}"/usr/include/netatalk{,2} || die
	sed -e 's/include <netatalk/include <netatalk2/g' \
		-i "${D}"usr/include/{netatalk2,atalk}/* || die
}
