# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-power-manager/gnome-power-manager-2.18.3.ebuild,v 1.8 2007/08/10 13:16:50 angelos Exp $

inherit gnome2 eutils

DESCRIPTION="Gnome Power Manager"
HOMEPAGE="http://www.gnome.org/projects/gnome-power-manager/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ppc sparc ~x86 ~x86-fbsd"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2.6.0
		 >=x11-libs/gtk+-2.10.0
		 >=gnome-base/gnome-keyring-0.6.0
		 >=gnome-base/libgnome-2.14.0
		 >=gnome-base/libgnomeui-2.14.0
		 >=sys-apps/hal-0.5.8
		 >=dev-libs/dbus-glib-0.71
		 >=gnome-base/libglade-2.5.0
		 >=x11-libs/libnotify-0.4.3
		 >=x11-libs/libwnck-2.10.0
		 >=x11-libs/cairo-1.0.0
		 >=gnome-base/gnome-panel-2
		 >=gnome-base/gconf-2
		  =media-libs/gstreamer-0.10*
		   x11-libs/libX11
		   x11-libs/libXext"
DEPEND="${RDEPEND}
		  sys-devel/gettext
		 ~app-text/docbook-xml-dtd-4.3
		>=dev-util/pkgconfig-0.9
		>=dev-util/intltool-0.35
		>=app-text/gnome-doc-utils-0.3.2
		doc?	(
					 app-text/xmlto
					 app-text/docbook-sgml-utils
					~app-text/docbook-xml-dtd-4.4
					~app-text/docbook-sgml-dtd-4.1
					~app-text/docbook-xml-dtd-4.1.2
				)"

# docbook-sgml-utils and docbook-sgml-dtd-4.1 used for creating man pages
# (files under ${S}/man).
# docbook-xml-dtd-4.4 and -4.1.2 are used by the xml files under ${S}/docs.

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	# TODO :: policykit should have a pam useflag

	G2CONF="$(use_enable doc docbook-docs) \
			--enable-actions-menu --with-dpms-ext --disable-policykit \
			--enable-xevents --enable-applets --enable-keyring"
}

src_unpack() {
	gnome2_src_unpack

	# Use gst-launch-0.10 rather than gst-launch
	epatch ${FILESDIR}/gpm-2.18.3-slotted-gstreamer.patch

	if use doc; then
		# Actually install all html files, not just the index
		sed -i -e 's:\(htmldoc_DATA = \).*:\1$(SPEC_HTML_FILES):' \
			${S}/docs/Makefile.in
	else
		# Remove the docbook2man rules here since it's not handled by a proper
		# parameter in configure.in.
		sed -i -e 's:@HAVE_DOCBOOK2MAN_TRUE@.*::' ${S}/man/Makefile.in
	fi

	# glibc splits this out, whereas other libc's do not tend to
	use elibc_glibc || sed -i -e 's/-lresolv//' configure
}

pkg_postinst() {
	gnome2_pkg_postinst

	if [[ $(portageq has_version / 'sys-libs/pam') ]] ; then
		einfo "You will need the masked pam_console to be able to"
		einfo "suspend/hibernate, or you will need to:"
		einfo "touch /var/run/console/<USERNAME>"
		einfo "after each boot"
	fi
}
