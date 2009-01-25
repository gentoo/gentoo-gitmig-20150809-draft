# Copyright 2000-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tasque/tasque-0.1.8.ebuild,v 1.2 2009/01/25 05:22:25 mr_bones_ Exp $

EAPI=2

inherit gnome.org mono autotools

DESCRIPTION="Tasky is a simple task management app (TODO list) for the Linux Desktop"
HOMEPAGE="http://live.gnome.org/Tasque"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+rememberthemilk eds +sqlite hiveminder debug"

RDEPEND=">=dev-dotnet/gtk-sharp-2.12.7-r5
	>=dev-dotnet/gnome-sharp-2.24.0
	>=dev-dotnet/notify-sharp-0.4.0_pre20080912
	>=dev-dotnet/dbus-sharp-0.6
	>=dev-dotnet/dbus-glib-sharp-0.4
	eds? ( >=dev-dotnet/evolution-sharp-0.18.1 )
	sqlite? ( dev-db/sqlite:3 )
	"

DEPEND="${RDEPEND}"

pkg_setup() {
	BACKEND=false
	for usef in eds sqlite hiveminder rememberthemilk
	do
		use $usef && BACKEND=true
	done
	if [[ "${BACKEND}" != "true" ]]
	then
		eerror "You must select one of the following backends by enabling their useflag:"
		eerror "eds			( integrates with the evolution schedule )"
		eerror "sqlite		( uses a local, file-backed database to keep track of your TODO list )"
		eerror "rememberthemilk	( integrates with www.rememberthemilk.com )"
		eerror "hiveminder		( integrates with www.hiveminder.com )"
		die "Please select a backend"
	fi
}

src_prepare() {
	#http://bugzilla.gnome.org/show_bug.cgi?id=566355
	epatch "${FILESDIR}"/${P}-debug-fixup.patch
	eautoreconf
}

src_configure() {
	#http://bugzilla.gnome.org/show_bug.cgi?id=568910
	export	GTK_DOTNET_20_LIBS=" " \
		GTK_DOTNET_20_CFLAGS=" "
	econf	--disable-backend-icecore \
		--enable-backend-rtm \
		$(use_enable sqlite backend-sqlite) \
		$(use_enable eds backend-eds) \
		$(use_enable hiveminder backend-hiveminder) \
		$(use_enable debug)
}

src_install() {
	make DESTDIR="${D}" install || die "emake failed"
	dodoc NEWS TODO README AUTHORS || die "docs installation failed"
}
