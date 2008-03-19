# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usermode/usermode-1.96.ebuild,v 1.1 2008/03/19 06:54:17 dberkholz Exp $

inherit flag-o-matic rpm autotools eutils

# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="1"

DESCRIPTION="Tools for certain user account management tasks"
HOMEPAGE="https://fedorahosted.org/usermode/"
SRC_URI="mirror://fedora-dev/development/source/SRPMS/${P}-${RPMREV}.src.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="debug selinux"
RDEPEND="=dev-libs/glib-2*
	=x11-libs/gtk+-2*
	=gnome-base/libglade-2*
	sys-apps/attr
	x11-libs/libSM
	dev-util/desktop-file-utils
	sys-libs/system-config-base
	>=sys-libs/pam-0.75
	sys-apps/shadow
	dev-perl/XML-Parser
	sys-libs/libuser"
DEPEND="${RDEPEND}
	sys-devel/gettext"

pkg_setup() {
	if ! built_with_use sys-apps/shadow pam; then
		eerror "${CATEGORY}/${PN} depends on the chfn and passwd PAM service"
		eerror "configuration files installed by sys-apps/shadow with PAM"
		eerror "enabled."
		eerror "Please re-install sys-apps/shadow with the pam USE flag"
		eerror "enabled."
		die "sys-apps/shadow was built without PAM support."
	fi
}

src_unpack() {
	rpm_src_unpack
	cd "${S}"

	# Change vendor prefix of desktop file from redhat to gentoo
	sed -i -e "s:^\(VENDOR=\).*:\1gentoo:g" Makefile.am

	# Invalid categories in desktop-file-utils-0.11 (#153395)
	sed -i \
		-e "/AdvancedSettings/d" \
		-e "/Application/d" \
		-e "/X-Red-Hat-Base/d" \
		Makefile.am

	# Invalid naming of icons
	sed -i \
		-e "s:\.png::g" \
		*.desktop.in

	eautoreconf
}

src_compile() {
	append-ldflags -Wl,-z,now

	econf \
		$(use_with selinux) \
		$(use_enable debug) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# This needs to be suid, it's the main interface with suid-requiring stuff
	fperms 4711 /usr/sbin/userhelper

	# Don't install a shutdown executable, it will be preferred over /sbin/
	rm "${D}"/usr/bin/shutdown
}
