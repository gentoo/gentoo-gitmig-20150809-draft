# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rabbitmq-server/rabbitmq-server-1.8.0.ebuild,v 1.1 2010/07/03 08:21:06 hollow Exp $

EAPI="2"

inherit eutils

DESCRIPTION="RabbitMQ is a high-performance AMQP-compliant message broker written in Erlang."
HOMEPAGE="http://www.rabbitmq.com/"
SRC_URI="http://www.rabbitmq.com/releases/rabbitmq-server/v${PV}/rabbitmq-server-${PV}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/erlang"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	dev-python/simplejson
"

pkg_setup() {
	enewgroup rabbitmq
	enewuser rabbitmq -1 -1 -1 rabbitmq
}

src_install() {
	# erlang module
	local targetdir="/usr/$(get_libdir)/erlang/lib/${P}"

	einfo "Setting correct RABBITMQ_HOME in scripts"
	sed -e "s:^RABBITMQ_HOME=.*:RABBITMQ_HOME=\"${targetdir}\":g" \
		-i scripts/rabbitmq_env

	einfo "Installing Erlang module to ${targetdir}"
	insinto "${targetdir}"
	doins -r ebin include

	einfo "Installing server scripts to /usr/sbin"
	dosbin scripts/rabbitmq-multi scripts/rabbitmq-server scripts/rabbitmq-env \
		scripts/rabbitmq-activate-plugins scripts/rabbitmq-deactivate-plugins \
		scripts/rabbitmqctl

	# create the directory where our log file will go.
	diropts -m 0770 -o rabbitmq -g rabbitmq
	keepdir /var/log/rabbitmq

	# create the mnesia directory
	diropts -m 0770 -o rabbitmq -g rabbitmq
	dodir /var/lib/rabbitmq/mnesia

	# Install the init script
	newinitd "${FILESDIR}"/rabbitmq-server.init rabbitmq

	dodoc README
}
