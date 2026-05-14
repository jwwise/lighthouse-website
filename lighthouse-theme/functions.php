<?php

function lighthouse_enqueue_styles() {
	wp_enqueue_style( 'lighthouse-style', get_stylesheet_uri(), [], '1.0.0' );
}
add_action( 'wp_enqueue_scripts', 'lighthouse_enqueue_styles' );

function lighthouse_enqueue_fonts() {
	wp_enqueue_style(
		'lighthouse-fonts',
		'https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,400;9..40,500;9..40,600&family=Lora:ital,wght@0,400;0,500;1,400&display=swap',
		[],
		null
	);
}
add_action( 'wp_enqueue_scripts', 'lighthouse_enqueue_fonts' );
add_action( 'enqueue_block_editor_assets', 'lighthouse_enqueue_fonts' );

function lighthouse_setup() {
	add_theme_support( 'wp-block-styles' );
	add_theme_support( 'editor-styles' );
	add_editor_style( 'style.css' );
}
add_action( 'after_setup_theme', 'lighthouse_setup' );
