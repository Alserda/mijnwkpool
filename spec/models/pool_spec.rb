require 'spec_helper'

describe Pool do

  let(:pool) { Pool.new(name: 'The_Next_Web_Leeuwarden') }

  it 'is invalid without password if private' do
    pool.is_public = false
    pool.password = ''
    pool.password_confirmation = ''

    expect(pool).not_to be_valid

    pool.password = 'ikbenwacht'
    pool.password_confirmation = 'ikbenwacht'

    expect(pool).to be_valid

  end

  it 'clears password if is_public on save' do
    pool.is_public = true
    pool.password = 'ikbenwacht'
    pool.password_confirmation = 'ikbenwacht'

    pool.save
    expect(pool.password_digest).to be_empty

    pool.password = 'ikbenechtwelwachtwoord'

    pool.save
    expect(pool.password_digest).to be_empty

  end

  it 'matches passwords if private' do
    pool.is_public = false
    pool.password = 'ikbenwacht'
    pool.password_confirmation = 'ikbenwacht'

    expect(pool).to be_valid

    pool.password = 'ikbenwacht2'

    expect(pool).not_to be_valid

  end

  it 'name is valid' do
    pool.is_public = true
    pool.name = 'The-Next-Web_Leeuwarden123'
    expect(pool).to be_valid
  end

  it 'name is invalid' do
    pool.is_public = true
    pool.name = 'The__Next--Web Leeuwarden123  '
    expect(pool).not_to be_valid
  end
end
