# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/evolution/evolution-2.2.3.ebuild,v 1.1 2005/07/08 10:00:54 leonardop Exp $

inherit eutils flag-o-matic alternatives gnome2

DESCRIPTION="Integrated mail, addressbook and calendaring functionality"
HOMEPAGE="http://www.gnome.org/projects/evolution/"

LICENSE="GPL-2 FDL-1.1"
SLOT="2.0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="crypt dbus debug doc gstreamer ipv6 kerberos ldap mono mozilla nntp pda spell ssl static"

# Top stanza are ximian deps
# Pango dependency required to avoid font rendering problems
RDEPEND=">=gnome-extra/libgtkhtml-3.6.2
	>=gnome-extra/gal-2.4.2
	>=gnome-extra/evolution-data-server-1.2.2
	>=net-libs/libsoup-2.2
	>=dev-libs/glib-2
	>=dev-libs/libxml2-2
	>=x11-libs/pango-1.8.1
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2
	>=gnome-base/gnome-vfs-2.4
	>=gnome-base/libbonoboui-2.4.2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	>=x11-themes/gnome-icon-theme-1.2
	dev-libs/atk
	>=gnome-base/orbit-2.9.8
	mail-filter/spamassassin
	pda? ( >=app-pda/gnome-pilot-2
		>=app-pda/gnome-pilot-conduits-2 )
	spell? ( >=app-text/gnome-spell-1.0.5 )
	crypt? ( >=app-crypt/gnupg-1.2.2 )
	ssl? ( mozilla? ( www-client/mozilla )
		!mozilla? ( >=dev-libs/nspr-4.4.1
			>=dev-libs/nss-3.9.2 ) )
	ldap? ( >=net-nds/openldap-2 )
	kerberos? ( virtual/krb5 )
	gstreamer? ( =media-libs/gstreamer-0.8*
		=media-libs/gst-plugins-0.8* )
	dbus? ( <sys-apps/dbus-0.30 )
	mono? ( >=dev-lang/mono-1 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.30
	sys-devel/gettext
	sys-devel/bison
	app-text/scrollkeeper
	doc? ( >=dev-util/gtk-doc-0.6 )"

USE_DESTDIR="1"
DOCS="AUTHORS ChangeLog* HACKING MAINTAINERS NEWS* README"
ELTCONF="--reverse-deps"

src_compile() {
	local myconf="--disable-default-binary --enable-plugins=all \
		--without-kde-applnk-path $(use_enable static) $(use_enable ssl nss) \
		$(use_enable ssl smime) $(use_enable ipv6) $(use_enable mono) \
		$(use_enable nntp) $(use_enable pda pilot-conduits) \
		$(use_with ldap openldap) $(use_with kerberos krb5 /usr)"

	use ldap && myconf="${myconf} $(use_with static static-ldap)"

	# problems with -O3 on gcc-3.3.1
	replace-flags -O3 -O2

	if [ "${ARCH}" = "hppa" ]; then
		append-flags "-fPIC -ffunction-sections"
		export LDFLAGS="-ffunction-sections -Wl,--stub-group-size=25000"
	fi

	# Use Mozilla's NSS/NSPR libs if 'mozilla' *and* 'ssl' in USE
	# Use standalone NSS/NSPR if only 'ssl' in USE
	# Openssl support doesn't work and has been disabled in cvs
	# SSL support has almost entirely moved to e-d-s,
	# keep an eye on it in rev-bumps (HAVE_SSL)
	# <obz@gentoo.org>

	if use ssl ; then
		if  use mozilla ; then
			NSS_LIB=/usr/$(get_libdir)/mozilla
			NSPR_LIB=/usr/$(get_libdir)/mozilla
			NSS_INC=/usr/$(get_libdir)/mozilla/include/nss
			NSPR_INC=/usr/$(get_libdir)/mozilla/include/nspr
		else
			NSS_LIB=/usr/$(get_libdir)/nss
			NSPR_LIB=/usr/$(get_libdir)/nspr
			NSS_INC=/usr/include/nss
			NSPR_INC=/usr/include/nspr
		fi

		myconf="${myconf} --enable-nss=yes \
			--with-nspr-includes=${NSPR_INC} \
			--with-nspr-libs=${NSPR_LIB} \
			--with-nss-includes=${NSS_INC} \
			--with-nss-libs=${NSS_LIB}"
	else
		myconf="${myconf} --without-nspr-libs --without-nspr-includes \
		--without-nss-libs --without-nss-includes"
	fi

	G2CONF="${G2CONF} ${myconf}"

	gnome2_src_compile
}

src_install() {

	# work around #92920 FIXME
	gnome2_src_install scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/

}

pkg_postinst() {

	alternatives_auto_makesym "/usr/bin/evolution" "/usr/bin/evolution-[0-9].[0-9]"
	gnome2_gconf_install ${GCONFFILEPATH}
	einfo "To change the default browser if you are not using GNOME, do:"
	einfo "gconftool-2 --set /desktop/gnome/url-handlers/http/command -t string 'mozilla %s'"
	einfo "gconftool-2 --set /desktop/gnome/url-handlers/https/command -t string 'mozilla %s'"
	einfo ""
	einfo "Replace 'mozilla %s' with which ever browser you use."

}
