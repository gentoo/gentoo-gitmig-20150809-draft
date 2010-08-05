# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ivman/ivman-0.6.14-r1.ebuild,v 1.1 2010/08/05 22:04:31 hwoarang Exp $

inherit eutils

DESCRIPTION="Daemon to mount/unmount devices, based on info from HAL"
HOMEPAGE="http://ivman.sf.net"
SRC_URI="mirror://sourceforge/ivman/${P}.tar.bz2"
LICENSE="GPL-2 QPL"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"
SLOT="0"

RDEPEND=">=dev-libs/glib-2.6
	 dev-libs/libxml2
	 sys-devel/gettext
	 >=sys-apps/hal-0.4.0
	 >=sys-apps/pmount-0.8"

DEPEND="${RDEPEND}
	>=sys-devel/libtool-1.5
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Add support for hotpluggable devices (not removable)
	epatch "${FILESDIR}"/${PN}-0.6-hotpluggable.patch

	#Remove xmlCleanupParser. Bug #327729
	epatch "${FILESDIR}"/${P}-no_xmlCleanupParser.patch
}

src_compile() {
	econf $(use_enable debug) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	newinitd "${FILESDIR}"/ivman-0.3.init ivman

	# remove debugging help #182190
	sed -i -e "s:set -x::" "${D}"/usr/bin/ivman-launch
}

pkg_postinst() {
	# Ivman can now run as a non-root user :-)  Create a dedicated user account,
	# so users can add rules to /etc/sudoers for programs Ivman wants to
	# execute...
	# The group here is intended to be the one needed to use pmount, but Ivman
	# will still work as long as the group in IvmConfigBase.xml is correct.
	enewuser ivman -1 -1 /dev/null plugdev

	if has_version "<sys-apps/hal-0.5.0"; then
		einfo "Ivman was built against HAL 0.4.x.  If you later upgrade to HAL 0.5,"
		einfo "you must re-merge Ivman."
		echo
	else
		einfo "Ivman was built against HAL 0.5.x.  If you later downgrade to HAL 0.4,"
		einfo "you must re-merge Ivman."
		echo
	fi

	einfo "Note that, as of version 0.6.0, the IvmConfigMappings.xml configuration"
	einfo "file is no longer required to correctly mount fstab entries which"
	einfo "use symbolic links.  You may safely remove this file if desired."
	einfo "However, HAL typically does not correctly deal with fstab"
	einfo "entries of this nature, therefore it is strongly recommanded that"
	einfo "you have real device names (i.e. not symlinks) in /etc/fstab."
	echo

	einfo "By default, Ivman will mount any removable disks as they are"
	einfo "attached.  If you want Ivman to do more, such as hibernating"
	einfo "your laptop when the lid is closed or when the battery is low,"
	einfo "look at the configuration files in /etc/ivman/ ."
}
