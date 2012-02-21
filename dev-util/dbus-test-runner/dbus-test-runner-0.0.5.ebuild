# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dbus-test-runner/dbus-test-runner-0.0.5.ebuild,v 1.1 2012/02/21 15:57:15 johu Exp $

EAPI=4

MY_MAJOR_VERSION="trunk"

DESCRIPTION="Run executables under a new DBus session for testing"
HOMEPAGE="https://launchpad.net/dbus-test-runner"
SRC_URI="http://launchpad.net/dbus-test-runner/${MY_MAJOR_VERSION}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="test"

RDEPEND="
	dev-libs/dbus-glib
	dev-util/intltool
"
DEPEND="
	${RDEPEND}
	test? ( dev-util/bustle )
"
